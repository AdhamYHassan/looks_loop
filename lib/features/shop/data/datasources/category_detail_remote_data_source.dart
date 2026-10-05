import 'package:looks_loop/features/home/data/models/home_feed_models.dart';
import 'package:looks_loop/features/shop/data/models/category_detail_models.dart';
import 'package:looks_loop/features/shop/data/models/shop_feed_models.dart';

abstract class CategoryDetailRemoteDataSource {
  Future<CategoryDetailModel> getCategoryDetail(String audienceId);
}

class CategoryDetailRemoteDataSourceImpl
    implements CategoryDetailRemoteDataSource {
  const CategoryDetailRemoteDataSourceImpl();

  static const List<SubCategoryModel> _defaultSubcategories = [
    SubCategoryModel(
      id: 'sub_clothing',
      name: 'CLOTHING',
      productCount: 18,
      imageUrl:
          'https://images.pexels.com/photos/8485650/pexels-photo-8485650.jpeg?auto=compress&cs=tinysrgb&w=600',
    ),
    SubCategoryModel(
      id: 'sub_dresses',
      name: 'DRESSES',
      productCount: 6,
      imageUrl:
          'https://images.pexels.com/photos/14801160/pexels-photo-14801160.jpeg?auto=compress&cs=tinysrgb&w=600',
    ),
    SubCategoryModel(
      id: 'sub_tops',
      name: 'TOPS',
      productCount: 4,
      imageUrl:
          'https://images.pexels.com/photos/39457718/pexels-photo-39457718.jpeg?auto=compress&cs=tinysrgb&w=600',
    ),
    SubCategoryModel(
      id: 'sub_shoes',
      name: 'SHOES',
      productCount: 4,
      imageUrl:
          'https://images.pexels.com/photos/26851193/pexels-photo-26851193.jpeg?auto=compress&cs=tinysrgb&w=600',
    ),
    SubCategoryModel(
      id: 'sub_bags',
      name: 'BAGS',
      productCount: 4,
      imageUrl:
          'https://images.pexels.com/photos/22432991/pexels-photo-22432991.jpeg?auto=compress&cs=tinysrgb&w=600',
    ),
    SubCategoryModel(
      id: 'sub_accessories',
      name: 'ACCESSORIES',
      productCount: 3,
      imageUrl:
          'https://images.pexels.com/photos/16567155/pexels-photo-16567155.jpeg?auto=compress&cs=tinysrgb&w=600',
    ),
  ];

  static const List<ProductModel> _railProducts = [
    ProductModel(
      id: 'shop_p1',
      brand: 'Studio Cairo',
      name: 'Relaxed Linen Shirt',
      price: 1450,
      imageUrl:
          'https://images.pexels.com/photos/15759112/pexels-photo-15759112.jpeg?auto=compress&cs=tinysrgb&w=700',
    ),
    ProductModel(
      id: 'shop_p2',
      brand: 'Nile Objects',
      name: 'Soft Structure Trousers',
      price: 2200,
      imageUrl:
          'https://images.pexels.com/photos/27028696/pexels-photo-27028696.jpeg?auto=compress&cs=tinysrgb&w=700',
    ),
    ProductModel(
      id: 'shop_p3',
      brand: 'House of Namaa',
      name: 'Sculpted Cotton Dress',
      price: 3850,
      imageUrl:
          'https://images.pexels.com/photos/18226047/pexels-photo-18226047.jpeg?auto=compress&cs=tinysrgb&w=700',
    ),
    ProductModel(
      id: 'shop_p4',
      brand: 'MANGO',
      name: 'Wide Leg Trousers',
      price: 1590,
      originalPrice: 1890,
      discountPercent: 16,
      imageUrl:
          'https://images.pexels.com/photos/8558355/pexels-photo-8558355.jpeg?auto=compress&cs=tinysrgb&w=700',
    ),
    ProductModel(
      id: 'shop_p5',
      brand: 'Common Ground',
      name: 'Everyday Leather Loafer',
      price: 2750,
      imageUrl:
          'https://images.pexels.com/photos/13536939/pexels-photo-13536939.jpeg?auto=compress&cs=tinysrgb&w=700',
    ),
  ];

  static const ShopEditorialModel _editorial = ShopEditorialModel(
    eyebrow: 'THE SUMMER EDIT',
    titleLine1: 'LIGHT LAYERS.',
    titleLine2: 'NEW TEXTURES.',
    ctaText: 'DISCOVER THE EDIT',
    imageUrl:
        'https://images.pexels.com/photos/28123291/pexels-photo-28123291.jpeg?auto=compress&cs=tinysrgb&w=1200',
  );

  @override
  Future<CategoryDetailModel> getCategoryDetail(String audienceId) async {
    await Future.delayed(const Duration(milliseconds: 200));

    final String title = switch (audienceId) {
      'aud_men' => 'MEN',
      'aud_kids' => 'KIDS',
      _ => 'WOMEN',
    };

    return CategoryDetailModel(
      audienceId: audienceId,
      audienceTitle: title,
      totalProductCount: 42,
      subcategories: _defaultSubcategories,
      editorial: _editorial,
      railProducts: _railProducts,
    );
  }
}
