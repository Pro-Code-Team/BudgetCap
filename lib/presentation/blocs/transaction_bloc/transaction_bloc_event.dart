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

//FORM HANDLERS

class FormFieldChanged extends TransactionBlocEvent {
  final String fieldName;
  final String fieldValue;

  const FormFieldChanged({
    required this.fieldName,
    required this.fieldValue,
  });
}

class FormSubmitted extends TransactionBlocEvent {
  final Map<String, String> formData;
  final BuildContext context;

  FormSubmitted({required this.formData, required this.context});
}
