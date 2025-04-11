part of 'transaction_bloc.dart';

sealed class TransactionBlocEvent {
  const TransactionBlocEvent();
}

class TransactionFetchAll extends TransactionBlocEvent {
  const TransactionFetchAll();
}

class TransactionCreated extends TransactionBlocEvent {
  final Transaction transaction;
  final BuildContext context;

  const TransactionCreated({required this.transaction, required this.context});
}

//FORM HANDLERS

class TransactionFormFieldChanged extends TransactionBlocEvent {
  final String fieldName;
  final dynamic fieldValue;

  const TransactionFormFieldChanged({
    required this.fieldName,
    required this.fieldValue,
  });
}

class TransactionFormSubmitted extends TransactionBlocEvent {
  final int? transactionId;
  final BuildContext context;

  TransactionFormSubmitted({
    this.transactionId,
    required this.context,
  });
}

class TransactionFetchedById extends TransactionBlocEvent {
  final int transactionToBeFetched;

  TransactionFetchedById({required this.transactionToBeFetched});
}

class TransactionDelete extends TransactionBlocEvent {
  final int transactionId;

  TransactionDelete({required this.transactionId});
}
