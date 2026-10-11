import 'package:looks_loop/features/home/data/models/home_feed_models.dart';
import 'package:looks_loop/features/home/domain/entities/home_feed_entities.dart';
import 'package:looks_loop/features/shop/data/models/shop_feed_models.dart';
import 'package:looks_loop/features/shop/domain/entities/shop_feed_entities.dart';

class ShopMockData {
  ShopMockData._();

  static const List<ShopAudienceEntity> audiences = [
    ShopAudienceModel(
      id: 'aud_women',
      title: 'WOMEN',
      imageUrl: 'https://images.pexels.com/photos/18226047/pexels-photo-18226047.jpeg?auto=compress&cs=tinysrgb&w=1000',
      isLarge: true,
    ),
    ShopAudienceModel(
      id: 'aud_men',
      title: 'MEN',
      imageUrl: 'https://images.pexels.com/photos/8558355/pexels-photo-8558355.jpeg?auto=compress&cs=tinysrgb&w=1000',
      isLarge: false,
    ),
    ShopAudienceModel(
      id: 'aud_kids',
      title: 'KIDS',
      imageUrl: 'https://images.pexels.com/photos/31823166/pexels-photo-31823166.jpeg?auto=compress&cs=tinysrgb&w=1000',
      isLarge: false,
    ),
  ];

  static const List<String> quickLinks = ['NEW IN', 'BEST SELLERS', 'SALE', 'BRANDS'];

  static const List<ShopCategoryEntity> categories = [
    ShopCategoryModel(
      id: 'cat_clothing',
      name: 'CLOTHING',
      productCount: 18,
      imageUrl: 'https://images.pexels.com/photos/8485650/pexels-photo-8485650.jpeg?auto=compress&cs=tinysrgb&w=600',
    ),
    ShopCategoryModel(
      id: 'cat_dresses',
      name: 'DRESSES',
      productCount: 6,
      imageUrl: 'https://images.pexels.com/photos/14801160/pexels-photo-14801160.jpeg?auto=compress&cs=tinysrgb&w=600',
    ),
    ShopCategoryModel(
      id: 'cat_tops',
      name: 'TOPS',
      productCount: 4,
      imageUrl: 'https://images.pexels.com/photos/39457718/pexels-photo-39457718.jpeg?auto=compress&cs=tinysrgb&w=600',
    ),
    ShopCategoryModel(
      id: 'cat_shoes',
      name: 'SHOES',
      productCount: 4,
      imageUrl: 'https://images.pexels.com/photos/26851193/pexels-photo-26851193.jpeg?auto=compress&cs=tinysrgb&w=600',
    ),
  ];

  static const ShopEditorialModel editorial = ShopEditorialModel(
    eyebrow: 'THE SUMMER EDIT',
    titleLine1: 'LIGHT LAYERS.',
    titleLine2: 'NEW TEXTURES.',
    ctaText: 'DISCOVER THE EDIT',
    imageUrl: 'https://images.pexels.com/photos/28123291/pexels-photo-28123291.jpeg?auto=compress&cs=tinysrgb&w=1200',
  );

  static const List<ProductEntity> newInProducts = [
    ProductModel(
      id: 'shop_p1',
      brand: 'Studio Cairo',
      name: 'Relaxed Linen Shirt',
      price: 1450,
      imageUrl: 'https://images.pexels.com/photos/15759112/pexels-photo-15759112.jpeg?auto=compress&cs=tinysrgb&w=700',
    ),
    ProductModel(
      id: 'shop_p2',
      brand: 'Nile Objects',
      name: 'Soft Structure Trousers',
      price: 2200,
      imageUrl: 'https://images.pexels.com/photos/27028696/pexels-photo-27028696.jpeg?auto=compress&cs=tinysrgb&w=700',
    ),
    ProductModel(
      id: 'shop_p3',
      brand: 'House of Namaa',
      name: 'Sculpted Cotton Dress',
      price: 3850,
      imageUrl: 'https://images.pexels.com/photos/18226047/pexels-photo-18226047.jpeg?auto=compress&cs=tinysrgb&w=700',
    ),
    ProductModel(
      id: 'shop_p4',
      brand: 'MANGO',
      name: 'Wide Leg Trousers',
      price: 1590,
      originalPrice: 1890,
      discountPercent: 16,
      imageUrl: 'https://images.pexels.com/photos/8558355/pexels-photo-8558355.jpeg?auto=compress&cs=tinysrgb&w=700',
    ),
    ProductModel(
      id: 'shop_p5',
      brand: 'Common Ground',
      name: 'Everyday Leather Loafer',
      price: 2750,
      imageUrl: 'https://images.pexels.com/photos/13536939/pexels-photo-13536939.jpeg?auto=compress&cs=tinysrgb&w=700',
    ),
  ];

  static const ShopSaleBannerModel saleBanner = ShopSaleBannerModel(
    eyebrow: 'SALE',
    title: 'UP TO 40% OFF',
    subTitle: 'SELECTED STYLES',
    ctaText: 'SHOP SALE',
  );

  static const List<BrandEntity> brands = [
    BrandModel(id: 1, name: 'MANGO', logo: 'mango'),
    BrandModel(id: 2, name: 'ZARA', logo: 'zara'),
    BrandModel(id: 3, name: 'Studio Cairo', logo: 'studio-cairo'),
    BrandModel(id: 4, name: 'Mara Studio', logo: 'mara'),
    BrandModel(id: 5, name: 'Nile Objects', logo: 'nile'),
    BrandModel(id: 6, name: 'House of Namaa', logo: 'namaa'),
    BrandModel(id: 7, name: 'Common Ground', logo: 'common'),
    BrandModel(id: 8, name: 'Form / Field', logo: 'form'),
  ];
}
