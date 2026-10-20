import 'package:looks_loop/features/home/domain/repositories/home_repository.dart';

class GetCachedAnnouncementsUseCase {
  final HomeRepository _repository;

  const GetCachedAnnouncementsUseCase(this._repository);

  Future<List<String>> call() {
    return _repository.getCachedAnnouncements();
  }
}
