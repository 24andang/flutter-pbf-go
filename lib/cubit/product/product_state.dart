part of 'product_cubit.dart';

@immutable
sealed class ProductState {}

final class ProductInitial extends ProductState {}

final class ProductLoading extends ProductState {}

final class ProductLoaded extends ProductState {
  final List<PbfProductModel> products;
  ProductLoaded(this.products);
}

final class ProductCreate extends ProductState {
  final PbfProductModel product;
  ProductCreate({required this.product});
}

final class ProductSuccess extends ProductState {
  final String message;
  ProductSuccess(this.message);
}

final class ProductError extends ProductState {
  final String message;
  ProductError(this.message);
}
