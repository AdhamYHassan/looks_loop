import 'package:equatable/equatable.dart';
import 'package:looks_loop/features/more/domain/entities/app_info_entity.dart';

enum AppInfoType {
  aboutUs,
  policy,
}

sealed class AppInfoState extends Equatable {
  const AppInfoState();

  @override
  List<Object?> get props => [];
}

final class AppInfoInitial extends AppInfoState {
  const AppInfoInitial();
}

final class AppInfoLoading extends AppInfoState {
  const AppInfoLoading();
}

final class AppInfoLoaded extends AppInfoState {
  final AppInfoEntity appInfo;

  const AppInfoLoaded(this.appInfo);

  @override
  List<Object?> get props => [appInfo];
}

final class AppInfoError extends AppInfoState {
  final String message;

  const AppInfoError(this.message);

  @override
  List<Object?> get props => [message];
}

