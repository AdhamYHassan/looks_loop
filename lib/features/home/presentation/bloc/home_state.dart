import 'package:equatable/equatable.dart';
import 'package:looks_loop/features/home/domain/entities/home_feed_entities.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

final class HomeInitial extends HomeState {
  const HomeInitial();
}

final class HomeLoading extends HomeState {
  const HomeLoading();
}

final class HomeLoaded extends HomeState {
  final HomeFeedData feedData;
  final Set<String> wishlistedProductIds;

  const HomeLoaded({
    required this.feedData,
    this.wishlistedProductIds = const {},
  });

  HomeLoaded copyWith({
    HomeFeedData? feedData,
    Set<String>? wishlistedProductIds,
  }) {
    return HomeLoaded(
      feedData: feedData ?? this.feedData,
      wishlistedProductIds: wishlistedProductIds ?? this.wishlistedProductIds,
    );
  }

  @override
  List<Object?> get props => [feedData, wishlistedProductIds];
}

final class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object?> get props => [message];
}
