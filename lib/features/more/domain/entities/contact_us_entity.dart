import 'package:equatable/equatable.dart';

class ContactUsEntity extends Equatable {
  final int id;
  final String mobile;

  const ContactUsEntity({
    required this.id,
    required this.mobile,
  });

  @override
  List<Object?> get props => [id, mobile];
}

