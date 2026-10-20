import 'package:equatable/equatable.dart';
import 'package:looks_loop/features/looks/domain/entities/look_entity.dart';

sealed class LooksState extends Equatable {
  const LooksState();

  @override
  List<Object?> get props => [];
}

final class LooksInitial extends LooksState {
  const LooksInitial();
}

final class LooksLoading extends LooksState {
  const LooksLoading();
}

final class LooksLoaded extends LooksState {
  final List<LookSummaryEntity> looks;

  const LooksLoaded(this.looks);

  @override
  List<Object?> get props => [looks];
}

final class LooksError extends LooksState {
  final String message;

  const LooksError(this.message);

  @override
  List<Object?> get props => [message];
}
