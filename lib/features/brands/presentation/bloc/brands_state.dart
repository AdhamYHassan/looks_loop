import 'package:equatable/equatable.dart';
import 'package:looks_loop/features/brands/domain/entities/brand_entity.dart';

sealed class BrandsState extends Equatable {
  const BrandsState();

  @override
  List<Object?> get props => [];
}

class BrandsInitial extends BrandsState {
  const BrandsInitial();
}

class BrandsLoading extends BrandsState {
  const BrandsLoading();
}

class BrandsLoaded extends BrandsState {
  final List<BrandEntity> allBrands;
  final List<BrandEntity> featuredBrands;
  final Map<String, List<BrandEntity>> azBrands;
  final String searchQuery;
  final bool isSearching;

  const BrandsLoaded({
    required this.allBrands,
    required this.featuredBrands,
    required this.azBrands,
    this.searchQuery = '',
    this.isSearching = false,
  });

  BrandsLoaded copyWith({
    List<BrandEntity>? allBrands,
    List<BrandEntity>? featuredBrands,
    Map<String, List<BrandEntity>>? azBrands,
    String? searchQuery,
    bool? isSearching,
  }) {
    return BrandsLoaded(
      allBrands: allBrands ?? this.allBrands,
      featuredBrands: featuredBrands ?? this.featuredBrands,
      azBrands: azBrands ?? this.azBrands,
      searchQuery: searchQuery ?? this.searchQuery,
      isSearching: isSearching ?? this.isSearching,
    );
  }

  @override
  List<Object?> get props => [
        allBrands,
        featuredBrands,
        azBrands,
        searchQuery,
        isSearching,
      ];
}

class BrandsError extends BrandsState {
  final String message;

  const BrandsError(this.message);

  @override
  List<Object?> get props => [message];
}
