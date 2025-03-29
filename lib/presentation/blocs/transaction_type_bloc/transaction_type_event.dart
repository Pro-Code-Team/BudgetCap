part of 'transaction_type_bloc.dart';

sealed class TransactionTypeEvent {
  const TransactionTypeEvent();
}

class TransactionTypeChanged extends TransactionTypeEvent {
  final Enum selectedTransactionType;

  const TransactionTypeChanged({required this.selectedTransactionType});
}
