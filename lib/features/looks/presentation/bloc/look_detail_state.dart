import 'package:equatable/equatable.dart';
import 'package:looks_loop/features/home/domain/entities/featured_look_entity.dart';

sealed class LookDetailState extends Equatable {
  const LookDetailState();

  @override
  List<Object?> get props => [];
}

final class LookDetailInitial extends LookDetailState {
  const LookDetailInitial();
}

final class LookDetailLoading extends LookDetailState {
  const LookDetailLoading();
}

final class LookDetailLoaded extends LookDetailState {
  final FeaturedLookEntity look;
  final String? addingProductId;
  final String? bagActionMessage;

  const LookDetailLoaded(
    this.look, {
    this.addingProductId,
    this.bagActionMessage,
  });

  LookDetailLoaded copyWith({
    FeaturedLookEntity? look,
    String? Function()? addingProductId,
    String? Function()? bagActionMessage,
  }) {
    return LookDetailLoaded(
      look ?? this.look,
      addingProductId:
          addingProductId != null ? addingProductId() : this.addingProductId,
      bagActionMessage:
          bagActionMessage != null ? bagActionMessage() : this.bagActionMessage,
    );
  }

  @override
  List<Object?> get props => [look, addingProductId, bagActionMessage];
}

final class LookDetailError extends LookDetailState {
  final String message;

  const LookDetailError(this.message);

  @override
  List<Object?> get props => [message];
}
