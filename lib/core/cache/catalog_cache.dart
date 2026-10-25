import 'package:looks_loop/features/home/domain/entities/home_category_entity.dart';

class CatalogCache {
  List<CategoryEntity> _categories = const [];

  List<CategoryEntity> get categories => List.unmodifiable(_categories);

  bool get hasCategories => _categories.isNotEmpty;

  void saveCategories(List<CategoryEntity> items) {
    if (items.isNotEmpty) {
      _categories = List.unmodifiable(items);
    }
  }

  void clear() {
    _categories = const [];
  }
}
