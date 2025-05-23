part of 'transaction_bloc.dart';

sealed class TransactionEvent extends Equatable {
  const TransactionEvent();

  @override
  List<Object> get props => [];
}

final class TransactionStarted extends TransactionEvent {
  @override
  List<Object> get props => [];
}

final class TransactionSaved extends TransactionEvent {
  final Map<String, dynamic> formData;

  const TransactionSaved({required this.formData});

  @override
  List<Object> get props => [formData];
}
