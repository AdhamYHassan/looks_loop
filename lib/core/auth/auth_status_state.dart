import 'package:equatable/equatable.dart';
import 'package:looks_loop/features/more/domain/entities/user_profile_entity.dart';

sealed class AuthStatusState extends Equatable {
  const AuthStatusState();

  @override
  List<Object?> get props => [];
}

final class AuthStatusInitial extends AuthStatusState {
  const AuthStatusInitial();
}

final class AuthStatusGuest extends AuthStatusState {
  const AuthStatusGuest();
}

final class AuthStatusAuthenticated extends AuthStatusState {
  final UserProfileEntity user;

  const AuthStatusAuthenticated(this.user);

  @override
  List<Object?> get props => [user];
}

