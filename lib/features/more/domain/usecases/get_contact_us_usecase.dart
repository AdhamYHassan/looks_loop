import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/more/domain/entities/contact_us_entity.dart';
import 'package:looks_loop/features/more/domain/repositories/more_repository.dart';

class GetContactUsUseCase {
  final MoreRepository _repository;

  const GetContactUsUseCase(this._repository);

  Future<ApiResult<ContactUsEntity>> call() async {
    return await _repository.getContactUs();
  }
}

