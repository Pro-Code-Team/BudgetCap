part of 'transaction_bloc.dart';

sealed class TransactionBlocEvent {
  const TransactionBlocEvent();
}

class GetAllTransactions extends TransactionBlocEvent {
  const GetAllTransactions();
}

class RecordTransaction extends TransactionBlocEvent {
  final Transaction transaction;

  const RecordTransaction(this.transaction);
}
