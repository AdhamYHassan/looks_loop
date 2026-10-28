import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/more/domain/usecases/get_about_us_usecase.dart';
import 'package:looks_loop/features/more/domain/usecases/get_policy_usecase.dart';
import 'package:looks_loop/features/more/presentation/bloc/app_info_state.dart';

class AppInfoCubit extends Cubit<AppInfoState> {
  final GetAboutUsUseCase _getAboutUsUseCase;
  final GetPolicyUseCase _getPolicyUseCase;

  AppInfoCubit(
    this._getAboutUsUseCase,
    this._getPolicyUseCase,
  ) : super(const AppInfoInitial());

  Future<void> loadInfo(AppInfoType type) async {
    emit(const AppInfoLoading());

    final result = switch (type) {
      AppInfoType.aboutUs => await _getAboutUsUseCase(),
      AppInfoType.policy => await _getPolicyUseCase(),
    };

    switch (result) {
      case ApiSuccess(:final data):
        emit(AppInfoLoaded(data));
      case ApiFailure(:final failure):
        emit(AppInfoError(failure.message));
    }
  }
}

