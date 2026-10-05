import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/more/domain/usecases/get_user_profile_usecase.dart';
import 'package:looks_loop/features/more/presentation/bloc/more_state.dart';

class MoreCubit extends Cubit<MoreState> {
  final GetUserProfileUseCase _getUserProfileUseCase;

  MoreCubit(this._getUserProfileUseCase) : super(const MoreInitial());

  Future<void> loadUserProfile() async {
    emit(const MoreLoading());
    final result = await _getUserProfileUseCase();

    switch (result) {
      case ApiSuccess(:final data):
        emit(MoreLoaded(profile: data));
      case ApiFailure(:final failure):
        emit(MoreError(failure.message));
    }
  }
}
