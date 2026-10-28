import 'package:equatable/equatable.dart';
import 'package:looks_loop/features/more/domain/entities/contact_us_entity.dart';

sealed class ContactUsState extends Equatable {
  const ContactUsState();

  @override
  List<Object?> get props => [];
}

final class ContactUsInitial extends ContactUsState {
  const ContactUsInitial();
}

final class ContactUsLoading extends ContactUsState {
  const ContactUsLoading();
}

final class ContactUsSuccess extends ContactUsState {
  final ContactUsEntity contactUs;

  const ContactUsSuccess(this.contactUs);

  @override
  List<Object?> get props => [contactUs];
}

final class ContactUsError extends ContactUsState {
  final String message;

  const ContactUsError(this.message);

  @override
  List<Object?> get props => [message];
}

