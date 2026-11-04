import 'package:equatable/equatable.dart';
import 'package:looks_loop/features/more/domain/entities/user_profile_entity.dart';

sealed class AccountState extends Equatable {
  const AccountState();

  @override
  List<Object?> get props => [];
}

final class AccountInitial extends AccountState {
  const AccountInitial();
}

final class AccountLoading extends AccountState {
  const AccountLoading();
}

final class AccountLoaded extends AccountState {
  final UserProfileEntity profile;

  const AccountLoaded(this.profile);

  @override
  List<Object?> get props => [profile];
}

final class AccountUpdating extends AccountState {
  final UserProfileEntity currentProfile;

  const AccountUpdating(this.currentProfile);

  @override
  List<Object?> get props => [currentProfile];
}

final class AccountUpdateSuccess extends AccountState {
  final UserProfileEntity profile;

  const AccountUpdateSuccess(this.profile);

  @override
  List<Object?> get props => [profile];
}

final class AccountError extends AccountState {
  final String message;

  const AccountError(this.message);

  @override
  List<Object?> get props => [message];
}

