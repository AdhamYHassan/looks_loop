import 'package:looks_loop/features/home/data/datasources/home_mock_products.dart';
import 'package:looks_loop/features/home/data/models/home_feed_models.dart';

const kDefaultHomeFeedModel = HomeFeedModel(
  heroSlides: [
    HeroSlideModel(
      id: 'hero_1',
      imageUrl:
          'https://images.pexels.com/photos/8516840/pexels-photo-8516840.jpeg?auto=compress&cs=tinysrgb&w=1200',
      eyebrow: 'THE LOOK LOOPS EDIT',
      title: 'FASHION\nIN MOTION.',
      copy: 'Discover the looks, watch the style, shop what inspires you.',
      ctaText: 'EXPLORE LOOPS',
    ),
    HeroSlideModel(
      id: 'hero_2',
      imageUrl:
          'https://images.pexels.com/photos/15978212/pexels-photo-15978212.jpeg?auto=compress&cs=tinysrgb&w=1200',
      eyebrow: 'THE LOOK LOOPS EDIT',
      title: 'MODERN\nELEGANCE.',
      copy: 'Contemporary silhouettes designed for the timeless wardrobe.',
      ctaText: 'EXPLORE LOOPS',
    ),
    HeroSlideModel(
      id: 'hero_3',
      imageUrl:
          'https://images.pexels.com/photos/10679159/pexels-photo-10679159.jpeg?auto=compress&cs=tinysrgb&w=1200',
      eyebrow: 'THE LOOK LOOPS EDIT',
      title: 'SUMMER\nSTORIES.',
      copy: 'Effortless lightness and elevated essentials.',
      ctaText: 'EXPLORE LOOPS',
    ),
  ],
  categories: [
    CategoryModel(
      id: 'cat_women',
      name: 'WOMEN',
      imageUrl:
          'https://images.pexels.com/photos/18226047/pexels-photo-18226047.jpeg?auto=compress&cs=tinysrgb&w=1000',
    ),
    CategoryModel(
      id: 'cat_men',
      name: 'MEN',
      imageUrl:
          'https://images.pexels.com/photos/8558355/pexels-photo-8558355.jpeg?auto=compress&cs=tinysrgb&w=1000',
    ),
    CategoryModel(
      id: 'cat_kids',
      name: 'KIDS',
      imageUrl:
          'https://images.pexels.com/photos/31823166/pexels-photo-31823166.jpeg?auto=compress&cs=tinysrgb&w=1000',
    ),
  ],
  newInProducts: kMockProducts,
  trendingItems: kMockTrendingItems,
  curatedLook: CuratedLookModel(
    id: 'curated_1',
    eyebrow: '04 / CURATED FOR YOU',
    title: 'SHOP THE LOOK',
    piecesLabel: 'CITY ESSENTIALS · 4 PIECES',
    imageUrl:
        'https://images.pexels.com/photos/5836324/pexels-photo-5836324.jpeg?auto=compress&cs=tinysrgb&w=1000',
    ctaText: 'SHOP THIS LOOK',
  ),
  motionReels: [
    MotionReelModel(
      id: 'reel_1',
      title: 'Studio Cairo / SS26',
      views: '12.4K views',
      thumbnailUrl:
          'https://images.pexels.com/photos/15759112/pexels-photo-15759112.jpeg?auto=compress&cs=tinysrgb&w=700',
    ),
    MotionReelModel(
      id: 'reel_2',
      title: 'Mara Studio / The Crescent',
      views: '8.7K views',
      thumbnailUrl:
          'https://images.pexels.com/photos/8499032/pexels-photo-8499032.jpeg?auto=compress&cs=tinysrgb&w=700',
    ),
    MotionReelModel(
      id: 'reel_3',
      title: 'Nile Objects / In Motion',
      views: '5.2K views',
      thumbnailUrl:
          'https://images.pexels.com/photos/9463000/pexels-photo-9463000.jpeg?auto=compress&cs=tinysrgb&w=700',
    ),
  ],
  brands: [
    BrandModel(id: 'b1', name: 'MANGO', logoAssetOrUrl: 'MANGO'),
    BrandModel(id: 'b2', name: 'ZARA', logoAssetOrUrl: 'ZARA'),
    BrandModel(id: 'b3', name: 'Studio Cairo', logoAssetOrUrl: 'Studio Cairo'),
    BrandModel(id: 'b4', name: 'Mara Studio', logoAssetOrUrl: 'Mara Studio'),
    BrandModel(id: 'b5', name: 'Nile Objects', logoAssetOrUrl: 'Nile Objects'),
    BrandModel(id: 'b6', name: 'House of Namaa', logoAssetOrUrl: 'House of Namaa'),
    BrandModel(id: 'b7', name: 'Common Ground', logoAssetOrUrl: 'Common Ground'),
    BrandModel(id: 'b8', name: 'Form / Field', logoAssetOrUrl: 'Form / Field'),
  ],
);
