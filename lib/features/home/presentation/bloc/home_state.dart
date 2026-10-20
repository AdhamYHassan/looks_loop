import 'package:equatable/equatable.dart';
import 'package:looks_loop/features/home/domain/entities/home_feed_entities.dart';

sealed class HomeState extends Equatable {
  final List<String> cachedAnnouncements;

  const HomeState({this.cachedAnnouncements = const []});

  List<String> get announcements => switch (this) {
        HomeLoaded(:final feedData) => feedData.announcements.isNotEmpty
            ? feedData.announcements
            : cachedAnnouncements,
        _ => cachedAnnouncements,
      };

  @override
  List<Object?> get props => [cachedAnnouncements];
}

final class HomeInitial extends HomeState {
  const HomeInitial({super.cachedAnnouncements});
}

final class HomeLoading extends HomeState {
  const HomeLoading({super.cachedAnnouncements});
}

final class HomeLoaded extends HomeState {
  final HomeFeedData feedData;
  final Set<String> wishlistedProductIds;

  const HomeLoaded({
    required this.feedData,
    this.wishlistedProductIds = const {},
    super.cachedAnnouncements,
  });

  HomeLoaded copyWith({
    HomeFeedData? feedData,
    Set<String>? wishlistedProductIds,
    List<String>? cachedAnnouncements,
  }) {
    return HomeLoaded(
      feedData: feedData ?? this.feedData,
      wishlistedProductIds: wishlistedProductIds ?? this.wishlistedProductIds,
      cachedAnnouncements: cachedAnnouncements ?? this.cachedAnnouncements,
    );
  }

  @override
  List<Object?> get props => [feedData, wishlistedProductIds, cachedAnnouncements];
}

final class HomeError extends HomeState {
  final String message;

  const HomeError(
    this.message, {
    super.cachedAnnouncements,
  });

  @override
  List<Object?> get props => [message, cachedAnnouncements];
}

