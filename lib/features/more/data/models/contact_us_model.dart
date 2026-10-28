import 'package:looks_loop/features/more/domain/entities/contact_us_entity.dart';

class ContactUsModel extends ContactUsEntity {
  const ContactUsModel({
    required super.id,
    required super.mobile,
  });

  factory ContactUsModel.fromJson(Map<String, dynamic> json) {
    return ContactUsModel(
      id: json['id'] as int? ?? 0,
      mobile: json['mobile'] as String? ?? '',
    );
  }
}

