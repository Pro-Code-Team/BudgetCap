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

class RecordAccount extends AccountEvent {
  final Account account;

  RecordAccount({required this.account});
}

class AccountFormInitializedValues extends AccountEvent {
  final Map<String, String> formData;

  const AccountFormInitializedValues({required this.formData});
}

//FORM HANDLERS

class AccountFormFieldChanged extends AccountEvent {
  final String fieldName;
  final String fieldValue;

  const AccountFormFieldChanged({
    required this.fieldName,
    required this.fieldValue,
  });
}

class AccountFormSubmitted extends AccountEvent {}

class AccountCategorySelected extends AccountEvent {
  final String iconName;

  AccountCategorySelected({required this.iconName});
}
