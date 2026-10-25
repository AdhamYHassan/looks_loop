import 'package:flutter_test/flutter_test.dart';
import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/home/data/datasources/home_remote_data_source.dart';
import 'package:looks_loop/features/home/data/models/home_feed_models.dart';
import 'package:looks_loop/features/home/data/repositories/home_repository_impl.dart';
import 'package:looks_loop/core/cache/catalog_cache.dart';
import 'package:looks_loop/features/home/domain/entities/home_feed_entities.dart';

import 'package:looks_loop/features/home/data/datasources/home_local_data_source.dart';

class FakeHomeRemoteDataSource implements HomeRemoteDataSource {
  final Future<HomeFeedModel> Function() onGet;

  FakeHomeRemoteDataSource(this.onGet);

  @override
  Future<HomeFeedModel> getHomeFeed() => onGet();
}

class FakeHomeLocalDataSource implements HomeLocalDataSource {
  List<String>? cached;

  FakeHomeLocalDataSource({this.cached});

  @override
  Future<void> cacheAnnouncements(List<String> announcements) async {
    cached = announcements;
  }

  @override
  Future<void> clearCache() async {
    cached = null;
  }

  @override
  Future<List<String>?> getCachedAnnouncements() async => cached;
}

void main() {
  const sampleJson = {
    'data': {
      'hero_slides': [
        {
          'id': 1,
          'eyebrow': 'SS26 / NEW SEASON',
          'title': 'DISCOVER\nWHAT\'S NEXT',
          'title_lines': ['DISCOVER', 'WHAT\'S NEXT'],
          'copy': 'A curated loop.',
          'image': 'https://a.com/hero.jpg',
          'primary_label': 'SHOP WOMEN',
          'primary_url': '/shop/women/',
          'secondary_label': 'SHOP MEN',
          'secondary_url': '/shop/men/',
        },
      ],
      'announcements': ['NEW DROPS EVERY FRIDAY — 8 PM', 'EASY RETURNS'],
      'categories': [
        {
          'id': 1,
          'name': 'Women',
          'slug': 'women',
          'tagline': 'Discover the latest pieces.',
          'image': 'https://a.com/cat.jpg',
          'subcategories': [
            {'id': 1, 'name': 'Clothing', 'slug': 'clothing', 'image': ''},
          ],
        },
      ],
      'new_in': [
        {
          'id': 8,
          'slug': 'mango-white-cotton-shirt',
          'name': 'White Cotton Shirt',
          'brand': {'id': 1, 'name': 'MANGO', 'slug': 'mango'},
          'category': 'women',
          'subcategory': 'tops',
          'price': '1450.00',
          'original_price': '1800.00',
          'discount_percentage': 20,
          'is_on_sale': true,
          'is_new': true,
          'image': 'https://a.com/shirt.jpg',
          'colors': [
            {'id': 16, 'name': 'Black', 'hex': '#1a1a1a'},
          ],
          'rating_average': '4.50',
          'rating_count': 10,
          'is_wishlisted': false,
        },
      ],
      'trending': [],
      'featured_loops': [
        {
          'id': 1,
          'slug': 'city-layers',
          'title': 'City Layers',
          'creator': '@studio.cairo',
          'thumbnail': 'https://a.com/loop.jpg',
          'video': '',
          'views': 18700,
          'likes_count': 2400,
          'liked': false,
          'brands': ['MANGO'],
          'products': [],
        },
      ],
      'featured_look': {
        'id': 2,
        'slug': 'soft-tailoring',
        'title': 'Soft ad',
        'description': 'Soft tailoring description.',
        'image': 'https://a.com/look.jpg',
        'is_featured': true,
        'hotspots': [
          {
            'x': 50.0,
            'y': 30.0,
            'product': {
              'id': 5,
              'name': 'White Shirt Dress',
              'brand': {'name': 'Studio Cairo'},
              'price': '2200.00',
              'image': 'https://a.com/dress.jpg',
            },
          },
        ],
      },
      'brands_to_know': [
        {
          'id': 1,
          'name': 'MANGO',
          'slug': 'mango',
          'description': 'Contemporary fashion.',
          'logo': 'https://a.com/logo.webp',
          'cover_image': '',
          'is_featured': true,
          'product_count': 15,
        },
      ],
      'sale': [],
      'editorial': {
        'id': 1,
        'eyebrow': 'THE EDIT / SS26',
        'title': 'THE NEW',
        'highlight': 'NEUTRALS.',
        'copy': 'Stone, sand and olive.',
        'cta_label': 'SHOP THE EDIT',
        'cta_url': '/new-in/',
        'image': 'https://a.com/editorial.jpg',
      },
    },
  };

  test('HomeRepositoryImpl parses and maps full payload correctly and caches announcements and categories', () async {
    final localDs = FakeHomeLocalDataSource();
    final catalogCache = CatalogCache();
    final repo = HomeRepositoryImpl(
      FakeHomeRemoteDataSource(() async => HomeFeedModel.fromJson(sampleJson)),
      localDs,
      catalogCache,
    );

    final result = await repo.getHomeFeed();

    expect(result, isA<ApiSuccess<HomeFeedData>>());
    final data = (result as ApiSuccess<HomeFeedData>).data;
    expect(data.heroSlides.length, 1);
    expect(data.heroSlides.first.titleLines.length, 2);
    expect(data.announcements.length, 2);
    expect(localDs.cached, ['NEW DROPS EVERY FRIDAY — 8 PM', 'EASY RETURNS']);
    expect(catalogCache.hasCategories, isTrue);
    expect(data.categories.length, 1);
    expect(data.categories.first.subcategories.length, 1);
    expect(data.newInProducts.length, 1);
    expect(data.newInProducts.first.price, 1450.0);
    expect(data.newInProducts.first.originalPrice, 1800.0);
    expect(data.newInProducts.first.colors.length, 1);
    expect(data.featuredLoops.length, 1);
    expect(data.featuredLook, isNotNull);
    expect(data.featuredLook!.hotspots.length, 1);
    expect(data.brands.length, 1);
    expect(data.brands.first.name, 'MANGO');
    expect(data.editorial, isNotNull);
    expect(data.editorial!.title, 'THE NEW');
  });

  test('HomeRepositoryImpl returns cached announcements without network call', () async {
    final localDs = FakeHomeLocalDataSource(cached: ['CACHED 1', 'CACHED 2']);
    final repo = HomeRepositoryImpl(
      FakeHomeRemoteDataSource(() async => throw UnimplementedError()),
      localDs,
      CatalogCache(),
    );

    final cached = await repo.getCachedAnnouncements();
    expect(cached, ['CACHED 1', 'CACHED 2']);
  });

  test(
    'HomeRepositoryImpl catches exceptions and returns ApiFailure',
    () async {
      final repo = HomeRepositoryImpl(
        FakeHomeRemoteDataSource(
          () async => throw Exception('Server unreachable'),
        ),
        FakeHomeLocalDataSource(),
        CatalogCache(),
      );

      final result = await repo.getHomeFeed();

      expect(result, isA<ApiFailure<HomeFeedData>>());
    },
  );
}
