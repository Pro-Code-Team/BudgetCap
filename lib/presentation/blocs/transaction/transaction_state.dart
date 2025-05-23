part of 'transaction_bloc.dart';

sealed class TransactionState extends Equatable {
  const TransactionState();

  @override
  List<Object> get props => [];
}

final class TransactionInitial extends TransactionState {
  @override
  List<Object> get props => [];
}

final class TransactionLoadInProgress extends TransactionState {
  @override
  List<Object> get props => [];
}

final class TransactionLoadSuccess extends TransactionState {
  final List<Transaction> transactions;

  const TransactionLoadSuccess({required this.transactions});

  @override
  List<Object> get props => [transactions];
}

final class TransactionLoadFailure extends TransactionState {
  final String error;

  const TransactionLoadFailure({required this.error});

  @override
  List<Object> get props => [error];
}

final class TransactionOperationInProgress extends TransactionState {
  @override
  List<Object> get props => [];
}

final class TransactionOperationFailure extends TransactionState {
  final String error;

  const TransactionOperationFailure({required this.error});

  @override
  List<Object> get props => [];
}

final class TransactionOperationSuccess extends TransactionState {
  final String message;

  const TransactionOperationSuccess({required this.message});

  @override
  List<Object> get props => [];
}
