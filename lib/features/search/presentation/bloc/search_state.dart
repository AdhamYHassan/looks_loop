import 'package:equatable/equatable.dart';
import 'package:looks_loop/features/search/domain/entities/search_result_entity.dart';

sealed class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object?> get props => [];
}

final class SearchInitial extends SearchState {
  const SearchInitial();
}

final class SearchLoading extends SearchState {
  final String query;

  const SearchLoading({required this.query});

  @override
  List<Object?> get props => [query];
}

final class SearchLoaded extends SearchState {
  final String query;
  final SearchResultEntity results;

  const SearchLoaded({
    required this.query,
    required this.results,
  });

  @override
  List<Object?> get props => [query, results];
}

final class SearchEmpty extends SearchState {
  final String query;

  const SearchEmpty({required this.query});

  @override
  List<Object?> get props => [query];
}

final class SearchError extends SearchState {
  final String message;

  const SearchError({required this.message});

  @override
  List<Object?> get props => [message];
}
