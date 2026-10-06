import 'package:equatable/equatable.dart';
import 'package:looks_loop/features/address/domain/entities/address_entity.dart';
import 'package:looks_loop/features/address/domain/entities/province_entity.dart';

/// Sealed UI State hierarchy for the Address feature.
sealed class AddressState extends Equatable {
  const AddressState();

  @override
  List<Object?> get props => [];
}

class AddressInitial extends AddressState {
  const AddressInitial();
}

class AddressLoading extends AddressState {
  const AddressLoading();
}

class AddressLoaded extends AddressState {
  final List<AddressEntity> addresses;
  final List<ProvinceEntity> provinces;
  final bool isSaving;

  const AddressLoaded({
    required this.addresses,
    this.provinces = const [],
    this.isSaving = false,
  });

  AddressLoaded copyWith({
    List<AddressEntity>? addresses,
    List<ProvinceEntity>? provinces,
    bool? isSaving,
  }) {
    return AddressLoaded(
      addresses: addresses ?? this.addresses,
      provinces: provinces ?? this.provinces,
      isSaving: isSaving ?? this.isSaving,
    );
  }

  @override
  List<Object?> get props => [addresses, provinces, isSaving];
}

class AddressActionSuccess extends AddressState {
  final String message;
  final List<AddressEntity> addresses;
  final List<ProvinceEntity> provinces;

  const AddressActionSuccess({
    required this.message,
    required this.addresses,
    this.provinces = const [],
  });

  @override
  List<Object?> get props => [message, addresses, provinces];
}

class AddressError extends AddressState {
  final String message;
  final List<AddressEntity> addresses;
  final List<ProvinceEntity> provinces;

  const AddressError({
    required this.message,
    this.addresses = const [],
    this.provinces = const [],
  });

  @override
  List<Object?> get props => [message, addresses, provinces];
}
