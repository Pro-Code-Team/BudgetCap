part of 'account_bloc.dart';

sealed class AccountEvent {
  const AccountEvent();
}

class AccountInitial extends AccountEvent {
  const AccountInitial();
}

class AccountSelected extends AccountEvent {
  final int accountSelected;

  const AccountSelected({required this.accountSelected});
}

class AccountToBeTransferredSelected extends AccountEvent {
  final int accountToBeTransferredSelected;

  AccountToBeTransferredSelected(
      {required this.accountToBeTransferredSelected});
}

class RecordAccount extends AccountEvent {
  final Account account;

  RecordAccount({required this.account});
}

//FORM HANDLERS

class FormFieldChanged extends AccountEvent {
  final String fieldName;
  final String fieldValue;

  const FormFieldChanged({
    required this.fieldName,
    required this.fieldValue,
  });
}

class FormSubmitted extends AccountEvent {
  final Map<String, String> formData;

  FormSubmitted({
    required this.formData,
  });
}
