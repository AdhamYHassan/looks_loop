import 'package:equatable/equatable.dart';
import 'package:looks_loop/features/auth/domain/entities/auth_response_entity.dart';

/// Sealed UI state union for registration and auto-login workflow.
sealed class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object?> get props => [];
}

final class RegisterInitial extends RegisterState {
  const RegisterInitial();
}

final class RegisterLoading extends RegisterState {
  const RegisterLoading();
}

final class RegisterSuccess extends RegisterState {
  final AuthResponseEntity authResponse;

  const RegisterSuccess(this.authResponse);

  @override
  List<Object?> get props => [authResponse];
}

final class RegisterError extends RegisterState {
  final String message;

  const RegisterError(this.message);

  @override
  List<Object?> get props => [message];
}
