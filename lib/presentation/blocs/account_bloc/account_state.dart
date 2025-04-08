part of 'account_bloc.dart';

class AccountState extends Equatable {
  final int? accountToBeTransferred;
  final int accountSelected;
  final bool isInProgress;
  final String message;
  final List<Account> accounts;
  final bool isSuccess;
  final Map<String, String> formData;

  const AccountState(
      {this.accountToBeTransferred = 1,
      this.formData = const {},
      this.accountSelected = 1,
      this.isInProgress = false,
      this.message = '',
      this.accounts = const [],
      this.isSuccess = false});

  AccountState copyWith({
    int? accountSelected,
    bool? isInProgress,
    String? message,
    List<Account>? accounts,
    bool? isSuccess,
    Map<String, String>? formData,
    int? accountToBeTransferred,
  }) {
    return AccountState(
        isSuccess: isSuccess ?? this.isSuccess,
        accountSelected: accountSelected ?? this.accountSelected,
        isInProgress: isInProgress ?? this.isInProgress,
        message: message ?? this.message,
        accounts: accounts ?? this.accounts,
        formData: formData ?? this.formData,
        accountToBeTransferred:
            accountToBeTransferred ?? this.accountToBeTransferred);
  }

  @override
  List<Object> get props => [
        accountSelected,
        isInProgress,
        message,
        accounts,
        isSuccess,
        formData,
        accountToBeTransferred!
      ];
}
