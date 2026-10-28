import 'package:equatable/equatable.dart';

class AppInfoEntity extends Equatable {
  final int id;
  final String title;
  final String content;
  final DateTime? updated;

  const AppInfoEntity({
    required this.id,
    required this.title,
    required this.content,
    this.updated,
  });

  @override
  List<Object?> get props => [id, title, content, updated];
}

