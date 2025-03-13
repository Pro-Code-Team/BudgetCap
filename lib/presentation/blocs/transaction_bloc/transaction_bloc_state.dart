part of 'transaction_bloc.dart';

class TransactionBlocState extends Equatable {
  //Handling the entire transaction which will bring all the parameters of the transaction.
  final bool isInProgress;
  final String message;
  final List<Transaction> transactions;

//We initialize the parameter when loading the widget for the first time.
  const TransactionBlocState(
      {this.isInProgress = false,
      this.message = '',
      this.transactions = const []});

  TransactionBlocState copyWith({
    bool? isInProgress,
    String? message,
    List<Transaction>? transactions,
  }) {
    return TransactionBlocState(
      isInProgress: isInProgress ?? this.isInProgress,
      message: message ?? this.message,
      transactions: transactions ?? this.transactions,
    );
  }

  @override
  List<Object> get props => [isInProgress, message, transactions];
}
