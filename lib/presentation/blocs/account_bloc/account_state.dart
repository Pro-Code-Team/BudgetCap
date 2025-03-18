part of 'account_bloc.dart';

class AccountState extends Equatable {
  final int accountSelected;
  final bool isInProgress;
  final String message;
  final List<Account> accounts;

  const AccountState(
      {this.accountSelected = 1,
      this.isInProgress = false,
      this.message = '',
      this.accounts = const []});

  AccountState copyWith({
    int? accountSelected,
    bool? isInProgress,
    String? message,
    List<Account>? accounts,
  }) {
    return AccountState(
      accountSelected: accountSelected ?? this.accountSelected,
      isInProgress: isInProgress ?? this.isInProgress,
      message: message ?? this.message,
      accounts: accounts ?? this.accounts,
    );
  }

  @override
  List<Object> get props => [accountSelected, isInProgress, message, accounts];
}
