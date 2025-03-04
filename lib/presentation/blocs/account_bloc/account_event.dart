part of 'account_bloc.dart';

sealed class AccountEvent {
  const AccountEvent();
}

class AccountInitial extends AccountEvent {
  const AccountInitial();
}

class AccountSelected extends AccountEvent {
  final String account;

  const AccountSelected(this.account);
}
