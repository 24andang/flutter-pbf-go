part of 'stock_cubit.dart';

@immutable
sealed class StockState {}

final class StockInitial extends StockState {}

final class StockLoading extends StockState {}

final class StockInHand extends StockState {
  final List<PbfInHandStockModel> stock;

  StockInHand(this.stock);
}

final class StockError extends StockState {
  final String error;
  final String detail;

  StockError(this.error, this.detail);
}
