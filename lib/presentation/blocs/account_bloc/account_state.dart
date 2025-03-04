part of 'account_bloc.dart';

class AccountState extends Equatable {
  final List<String> accounts;
  final String selectedAccount;

  AccountState({required this.accounts, String? selectedAccount})
      : selectedAccount = selectedAccount ?? accounts.first;

  AccountState copyWith({
    String? selectedAccount,
    List<String>? accounts,
  }) {
    return AccountState(
      selectedAccount: selectedAccount ?? this.selectedAccount,
      accounts: accounts ?? this.accounts,
    );
  }

  @override
  List<Object> get props => [accounts, selectedAccount];
}
