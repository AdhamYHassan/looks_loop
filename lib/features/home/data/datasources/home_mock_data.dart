import 'package:looks_loop/features/home/data/datasources/home_mock_products.dart';
import 'package:looks_loop/features/home/data/models/home_feed_models.dart';

const kDefaultHomeFeedModel = HomeFeedModel(
  heroSlides: [
    HeroSlideModel(
      id: 1,
      image:
          'https://images.pexels.com/photos/8516840/pexels-photo-8516840.jpeg?auto=compress&cs=tinysrgb&w=1200',
      eyebrow: 'THE LOOK LOOPS EDIT',
      title: 'FASHION\nIN MOTION.',
      copy: 'Discover the looks, watch the style, shop what inspires you.',
      primaryLabel: 'EXPLORE LOOPS',
      secondaryLabel: 'SHOP NEW',
    ),
    HeroSlideModel(
      id: 2,
      image:
          'https://images.pexels.com/photos/15978212/pexels-photo-15978212.jpeg?auto=compress&cs=tinysrgb&w=1200',
      eyebrow: 'THE LOOK LOOPS EDIT',
      title: 'MODERN\nELEGANCE.',
      copy: 'Contemporary silhouettes designed for the timeless wardrobe.',
      primaryLabel: 'EXPLORE LOOPS',
      secondaryLabel: 'SHOP NEW',
    ),
    HeroSlideModel(
      id: 3,
      image:
          'https://images.pexels.com/photos/10679159/pexels-photo-10679159.jpeg?auto=compress&cs=tinysrgb&w=1200',
      eyebrow: 'THE LOOK LOOPS EDIT',
      title: 'SUMMER\nSTORIES.',
      copy: 'Effortless lightness and elevated essentials.',
      primaryLabel: 'EXPLORE LOOPS',
      secondaryLabel: 'SHOP NEW',
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
  trendingProducts: kMockTrendingItems,
  featuredLook: FeaturedLookModel(
    id: 1,
    slug: 'city-essentials',
    title: 'SHOP THE LOOK',
    description: 'CITY ESSENTIALS · 4 PIECES',
    imageUrl:
        'https://images.pexels.com/photos/5836324/pexels-photo-5836324.jpeg?auto=compress&cs=tinysrgb&w=1000',
  ),
  featuredLoops: [
    FeaturedLoopModel(
      id: 1,
      slug: 'studio-cairo-ss26',
      title: 'Studio Cairo / SS26',
      creator: 'Studio Cairo',
      views: 12400,
      thumbnail:
          'https://images.pexels.com/photos/15759112/pexels-photo-15759112.jpeg?auto=compress&cs=tinysrgb&w=700',
    ),
    FeaturedLoopModel(
      id: 2,
      slug: 'mara-studio-crescent',
      title: 'Mara Studio / The Crescent',
      creator: 'Mara Studio',
      views: 8700,
      thumbnail:
          'https://images.pexels.com/photos/8499032/pexels-photo-8499032.jpeg?auto=compress&cs=tinysrgb&w=700',
    ),
  ],
  brands: [
    HomeBrandModel(id: 1, name: 'MANGO', logo: 'MANGO'),
    HomeBrandModel(id: 2, name: 'ZARA', logo: 'ZARA'),
    HomeBrandModel(id: 3, name: 'Studio Cairo', logo: 'Studio Cairo'),
    HomeBrandModel(id: 4, name: 'Mara Studio', logo: 'Mara Studio'),
    HomeBrandModel(id: 5, name: 'Nile Objects', logo: 'Nile Objects'),
    HomeBrandModel(id: 6, name: 'House of Namaa', logo: 'House of Namaa'),
    HomeBrandModel(id: 7, name: 'Common Ground', logo: 'Common Ground'),
    HomeBrandModel(id: 8, name: 'Form / Field', logo: 'Form / Field'),
  ],
);
