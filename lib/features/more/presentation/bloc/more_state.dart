import 'package:equatable/equatable.dart';
import 'package:looks_loop/features/more/domain/entities/user_profile_entity.dart';

sealed class MoreState extends Equatable {
  const MoreState();

  @override
  List<Object?> get props => [];
}

final class MoreInitial extends MoreState {
  const MoreInitial();
}

final class MoreLoading extends MoreState {
  const MoreLoading();
}

final class MoreLoaded extends MoreState {
  final UserProfileEntity profile;

  const MoreLoaded({required this.profile});

  @override
  List<Object?> get props => [profile];
}

final class MoreError extends MoreState {
  final String message;

  const MoreError(this.message);

  @override
  List<Object?> get props => [message];
}
