part of 'transaction_type_bloc.dart';

sealed class TransactionTypeEvent {
  const TransactionTypeEvent();
}

class TransactionChanged extends TransactionTypeEvent {
  final Enum selectedRecord;

  const TransactionChanged({required this.selectedRecord});
}
