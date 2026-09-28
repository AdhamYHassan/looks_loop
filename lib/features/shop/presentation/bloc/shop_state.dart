import 'package:equatable/equatable.dart';
import 'package:looks_loop/features/shop/domain/entities/shop_feed_entities.dart';

sealed class ShopState extends Equatable {
  const ShopState();

  @override
  List<Object?> get props => [];
}

final class ShopInitial extends ShopState {
  const ShopInitial();
}

final class ShopLoading extends ShopState {
  const ShopLoading();
}

final class ShopLoaded extends ShopState {
  final ShopFeedData feedData;
  final String selectedAudienceId;
  final String selectedQuickLink;
  final Set<String> wishlistedProductIds;

  const ShopLoaded({
    required this.feedData,
    this.selectedAudienceId = 'aud_women',
    this.selectedQuickLink = 'NEW IN',
    this.wishlistedProductIds = const {},
  });

  ShopLoaded copyWith({
    ShopFeedData? feedData,
    String? selectedAudienceId,
    String? selectedQuickLink,
    Set<String>? wishlistedProductIds,
  }) {
    return ShopLoaded(
      feedData: feedData ?? this.feedData,
      selectedAudienceId: selectedAudienceId ?? this.selectedAudienceId,
      selectedQuickLink: selectedQuickLink ?? this.selectedQuickLink,
      wishlistedProductIds: wishlistedProductIds ?? this.wishlistedProductIds,
    );
  }

  @override
  List<Object?> get props => [
        feedData,
        selectedAudienceId,
        selectedQuickLink,
        wishlistedProductIds,
      ];
}

final class ShopError extends ShopState {
  final String message;

  const ShopError(this.message);

  @override
  List<Object?> get props => [message];
}
