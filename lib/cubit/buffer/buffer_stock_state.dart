part of 'buffer_stock_cubit.dart';

@immutable
sealed class BufferStockState {}

final class BufferStockInitial extends BufferStockState {}

final class BufferStockLoading extends BufferStockState {}

final class BufferStockLoaded extends BufferStockState {
  final List<PbfBufferStockModel> buffer;

  BufferStockLoaded(this.buffer);
}

final class BufferStockHistory extends BufferStockState {
  final PbfBufferHistoryModel history;

  BufferStockHistory(this.history);
}

final class BufferStockSuccess extends BufferStockState {
  final String message;

  BufferStockSuccess(this.message);
}

final class BufferStockerror extends BufferStockState {
  final String error;
  final String detail;

  BufferStockerror(this.error, this.detail);
}
