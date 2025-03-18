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
