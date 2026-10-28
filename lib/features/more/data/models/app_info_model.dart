import 'package:looks_loop/features/more/domain/entities/app_info_entity.dart';

class AppInfoModel extends AppInfoEntity {
  const AppInfoModel({
    required super.id,
    required super.title,
    required super.content,
    super.updated,
  });

  factory AppInfoModel.fromJson(Map<String, dynamic> json) {
    return AppInfoModel(
      id: json['id'] as int? ?? 0,
      title: json['title'] as String? ?? '',
      content: json['content'] as String? ?? '',
      updated: json['updated'] != null
          ? DateTime.tryParse(json['updated'] as String)
          : null,
    );
  }
}

