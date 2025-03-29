part of 'transaction_bloc.dart';

class TransactionBlocState extends Equatable {
  //Handling the entire transaction which will bring all the parameters of the transaction.
  final bool isInProgress;
  final String message;
  final String errorMessage;
  final List<Transaction> transactions;
  final Map<String, String> formData;
  final bool isValid;

//We initialize the parameter when loading the widget for the first time.
  const TransactionBlocState({
    this.formData = const {},
    this.isValid = false,
    this.isInProgress = false,
    this.message = '',
    this.errorMessage = '',
    this.transactions = const [],
  });

  TransactionBlocState copyWith({
    bool? isInProgress,
    String? message,
    String? errorMessage,
    List<Transaction>? transactions,
    Map<String, String>? formData,
    bool? isValid,
  }) {
    return TransactionBlocState(
      isInProgress: isInProgress ?? this.isInProgress,
      message: message ?? this.message,
      errorMessage: errorMessage ?? this.errorMessage,
      transactions: transactions ?? this.transactions,
      formData: formData ?? this.formData,
      isValid: isValid ?? this.isValid,
    );
  }

  @override
  List<Object> get props => [
        isInProgress,
        message,
        errorMessage,
        transactions,
        formData,
        isValid,
      ];
}
