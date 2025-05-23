import 'package:budgetcap/domain/repositories/transaction_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:budgetcap/domain/entities/transaction.dart';
import 'package:equatable/equatable.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final TransactionRepository _transactionRepository;

  TransactionBloc({required TransactionRepository transactionRepository})
    : _transactionRepository = transactionRepository,
      super(TransactionInitial()) {
    on<TransactionStarted>(_onStarted);
    on<TransactionSaved>(_onSaved);
  }
  Future<void> _onStarted(TransactionStarted event, emit) async {
    emit(TransactionLoadInProgress);

    try {
      final transactions = await _transactionRepository.getAllTransactions();
      emit(TransactionLoadSuccess(transactions: transactions));
    } catch (e) {
      emit(TransactionLoadFailure(error: "Error fetching transactions: $e"));
    }
  }

  Future<void> _onSaved(TransactionSaved event, emit) async {
    emit(TransactionOperationInProgress());
    try {
      final formData = Map<String, dynamic>.from(event.formData);
      final transaction = Transaction(
        accountId: formData["id"],
        categoryId: formData["categoryId"],
        amount: formData["amount"],
        type: formData["type"],
        date: formData["date"],
        description: formData["description"],
      );
      await _transactionRepository.recordTransaction(transaction);
      emit(
        TransactionOperationSuccess(message: "Transaction saved successfully."),
      );
      final transactions = List<Transaction>.from(
        (state as TransactionLoadSuccess).transactions,
      );

      final index = transactions.indexWhere((tr) => tr.id == transaction.id);
      if (index != -1) {
        transactions[index] = transaction;
      } else {
        transactions.add(transaction);
      }
      emit(TransactionLoadSuccess(transactions: transactions));
    } catch (e) {
      emit(TransactionOperationFailure(error: "Error saving transaction: $e"));
    }
  }
}
