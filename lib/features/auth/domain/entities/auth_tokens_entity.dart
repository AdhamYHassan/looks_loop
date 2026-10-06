import 'package:equatable/equatable.dart';

class AuthTokensEntity extends Equatable {
  final String access;
  final String refresh;

  const AuthTokensEntity({
    required this.access,
    required this.refresh,
  });

  @override
  List<Object?> get props => [access, refresh];
}
