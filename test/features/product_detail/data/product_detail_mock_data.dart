import 'package:looks_loop/features/home/domain/entities/home_feed_entities.dart';
import 'package:looks_loop/features/product_detail/domain/entities/product_detail_entity.dart';
import 'package:looks_loop/features/product_detail/domain/entities/product_image_entity.dart';
import 'package:looks_loop/features/product_detail/domain/entities/product_size_entity.dart';
import 'package:looks_loop/features/product_detail/domain/entities/product_variant_entity.dart';
import 'package:looks_loop/features/product_detail/domain/entities/rating_distribution_entity.dart';

class ProductDetailMockData {
  ProductDetailMockData._();

  static const List<ProductImageEntity> _images = [
    ProductImageEntity(
      id: 29,
      url: 'https://images.pexels.com/photos/31977308/pexels-photo-31977308.jpeg?auto=compress&cs=tinysrgb&w=900',
      isPrimary: true,
      alt: 'White Cotton Shirt',
    ),
    ProductImageEntity(
      id: 30,
      url: 'https://images.pexels.com/photos/22432991/pexels-photo-22432991.jpeg?auto=compress&cs=tinysrgb&w=1200',
      alt: 'White Cotton Shirt',
    ),
    ProductImageEntity(
      id: 31,
      url: 'https://images.pexels.com/photos/27835299/pexels-photo-27835299.jpeg?auto=compress&cs=tinysrgb&w=1200',
      alt: 'White Cotton Shirt',
    ),
    ProductImageEntity(
      id: 32,
      url: 'https://images.pexels.com/photos/22434757/pexels-photo-22434757.jpeg?auto=compress&cs=tinysrgb&w=1200',
      alt: 'White Cotton Shirt',
    ),
  ];

  static const List<ProductColorEntity> _colors = [
    ProductColorEntity(id: 16, name: 'Black', hex: '0xFF1A1A1A'),
  ];

  static const List<ProductSizeEntity> _sizes = [
    ProductSizeEntity(id: 36, label: 'XS'),
    ProductSizeEntity(id: 37, label: 'S'),
    ProductSizeEntity(id: 38, label: 'M'),
    ProductSizeEntity(id: 39, label: 'L'),
    ProductSizeEntity(id: 40, label: 'XL'),
  ];

  static const List<ProductVariantEntity> _variants = [
    ProductVariantEntity(id: 76, sku: 'LL-W011-BLA-XS', colorId: 16, sizeId: 36, stock: 21, isAvailable: true),
    ProductVariantEntity(id: 77, sku: 'LL-W011-BLA-S', colorId: 16, sizeId: 37, stock: 19, isAvailable: true),
    ProductVariantEntity(id: 78, sku: 'LL-W011-BLA-M', colorId: 16, sizeId: 38, stock: 7, isAvailable: true),
    ProductVariantEntity(id: 79, sku: 'LL-W011-BLA-L', colorId: 16, sizeId: 39, stock: 4, isAvailable: true),
    ProductVariantEntity(id: 80, sku: 'LL-W011-BLA-XL', colorId: 16, sizeId: 40, stock: 0, isAvailable: false),
  ];

  static const List<RatingDistributionEntity> _distributions = [
    RatingDistributionEntity(star: 5, count: 0, percentage: 0.0),
    RatingDistributionEntity(star: 4, count: 0, percentage: 0.0),
    RatingDistributionEntity(star: 3, count: 0, percentage: 0.0),
    RatingDistributionEntity(star: 2, count: 0, percentage: 0.0),
    RatingDistributionEntity(star: 1, count: 0, percentage: 0.0),
  ];

  static const List<ProductEntity> _recommendedProducts = [
    ProductEntity(
      id: '20',
      slug: 'mara-studio-white-chain-bag',
      name: 'White Chain Bag',
      brand: 'Mara Studio',
      price: 2450.0,
      imageUrl: 'https://images.pexels.com/photos/27835299/pexels-photo-27835299.jpeg?auto=compress&cs=tinysrgb&w=900',
    ),
    ProductEntity(
      id: '15',
      slug: 'nile-objects-leather-ankle-boots',
      name: 'Leather Ankle Boots',
      brand: 'Nile Objects',
      price: 2750.0,
      imageUrl: 'https://images.pexels.com/photos/26851193/pexels-photo-26851193.jpeg?auto=compress&cs=tinysrgb&w=900',
    ),
    ProductEntity(
      id: '12',
      slug: 'mango-brown-tailored-trousers',
      name: 'Brown Tailored Trousers',
      brand: 'MANGO',
      price: 2100.0,
      imageUrl: 'https://images.pexels.com/photos/39457749/pexels-photo-39457749.jpeg?auto=compress&cs=tinysrgb&w=900',
    ),
  ];

  static const ProductDetailEntity sampleProductDetail = ProductDetailEntity(
    id: 8,
    slug: 'mango-white-cotton-shirt',
    brand: 'MANGO',
    name: 'White Cotton Shirt',
    price: 1450.0,
    sku: 'LL-W011',
    description: 'A refined essential cut from soft cotton. Designed to layer beautifully and hold its shape wash after wash.',
    materialCare: 'Shell: 100% genuine leather. Lining: Soft suede. Hardware: Gold-tone plated brass.\nWipe gently with a soft, dry cloth.',
    sizeFit: 'Model is 178 cm and wears size S. This piece runs true to size. For a relaxed fit, consider sizing up.',
    inStock: true,
    ratingAverage: 0.0,
    ratingCount: 0,
    isWishlisted: false,
    colors: _colors,
    sizes: _sizes,
    variants: _variants,
    images: _images,
    ratingDistribution: _distributions,
    reviews: [],
    related: _recommendedProducts,
  );
}
