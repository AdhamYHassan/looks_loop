import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/more/domain/usecases/get_contact_us_usecase.dart';
import 'package:looks_loop/features/more/presentation/bloc/contact_us_state.dart';

class ContactUsCubit extends Cubit<ContactUsState> {
  final GetContactUsUseCase _getContactUsUseCase;

  ContactUsCubit(this._getContactUsUseCase)
      : super(const ContactUsInitial());

  Future<void> fetchContactUs() async {
    emit(const ContactUsLoading());

    final result = await _getContactUsUseCase();

    switch (result) {
      case ApiSuccess(:final data):
        emit(ContactUsSuccess(data));
      case ApiFailure(:final failure):
        emit(ContactUsError(failure.message));
    }
  }
}

