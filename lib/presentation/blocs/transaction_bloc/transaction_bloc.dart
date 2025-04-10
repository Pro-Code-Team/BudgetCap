import 'dart:async';

import 'package:budgetcap/domain/entities/transaction.dart';
import 'package:budgetcap/infrastructure/repositories/transaction_repository_impl.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:equatable/equatable.dart';

part 'transaction_bloc_event.dart';
part 'transaction_bloc_state.dart';

class TransactionBloc extends Bloc<TransactionBlocEvent, TransactionBlocState> {
  final TransactionRepositoryImpl _repository;

  TransactionBloc(this._repository) : super(const TransactionBlocState()) {
    on<TransactionCreated>(_onTransactionCreated);
    on<TransactionFetchAll>(_onTransactionFetchAll);
    on<TransactionFormFieldChanged>(_onTransactionFormFieldChanged);
    on<TransactionFormSubmitted>(_onTransactionFormSubmitted);
    on<TransactionFetchedById>(_onTransactionFetchedById);
    on<TransactionDelete>(_onTransactionDelete);
  }

  Future<void> _onTransactionCreated(
      TransactionCreated event, Emitter<TransactionBlocState> emit) async {
    emit(state.copyWith(isInProgress: true));
    final bool isEditMode = event.transaction.id != null;
    Transaction transaction = event.transaction;

    try {
      if (isEditMode) {
        await _repository.updateTransaction(transaction);
      } else {
        final int id = await _repository.recordTransaction(transaction);
        transaction = transaction.copyWith(id: id);
      }

      final updatedTransactions = _updateTransactionList(
        state.transactions,
        transaction,
        isEditMode,
      );

      emit(state.copyWith(
        transactions: updatedTransactions,
        isInProgress: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        isInProgress: false,
        message: 'An unexpected error occurred: ${e.toString()}',
      ));
    }
  }

  List<Transaction> _updateTransactionList(List<Transaction> transactions,
      Transaction transaction, bool isEditMode) {
    final updatedList = List<Transaction>.from(transactions);
    if (isEditMode) {
      final index = updatedList.indexWhere((t) => t.id == transaction.id);
      if (index != -1) {
        updatedList[index] = transaction;
      }
    } else {
      updatedList.add(transaction);
    }
    return updatedList;
  }

  Future<void> _onTransactionFetchAll(
      TransactionFetchAll event, Emitter<TransactionBlocState> emit) async {
    emit(state.copyWith(isInProgress: true));
    try {
      emit(
          state.copyWith(transactions: await _repository.getAllTransactions()));
      emit(state.copyWith(isInProgress: false));
    } catch (e) {
      emit(state.copyWith(
        isInProgress: false,
        message: 'An unexpected error occurred: ${e.toString()}',
      ));
    }
  }

//FORM EVENTS
  void _onTransactionFormFieldChanged(
      TransactionFormFieldChanged event, Emitter<TransactionBlocState> emit) {
    final Map<String, dynamic> newFormData =
        Map<String, dynamic>.from(state.formData);
    newFormData[event.fieldName] = event.fieldValue;
    emit(state.copyWith(formData: newFormData));
  }

  Future<void> _onTransactionFormSubmitted(TransactionFormSubmitted event,
      Emitter<TransactionBlocState> emit) async {
    //Copy of form data to add a new field to the formData
    final Map<String, dynamic> formData =
        Map<String, dynamic>.from(state.formData);

    // Validar campos requeridos
    if (formData['amount'] == null || formData['amount']!.isEmpty) {
      emit(state.copyWith(isValid: false, message: 'Amount is required'));
      return;
    }

    if (double.tryParse(formData['amount']!) == null) {
      emit(state.copyWith(
          isValid: false, message: 'Amount must be a valid number'));
      return;
    }

    emit(state.copyWith(isValid: true, message: ''));
    formData['id'] = event.transactionId;

    if (formData['transaction_type'] != "income") {
      //Converting amount to negative
      formData['amount'] = double.parse(formData['amount']!) * -1;
    }

    // Do this if INCOME or EXPENSE
    final Transaction transaction = _createTransactionFromForm(formData);

    // Emitir evento para crear o actualizar la transacción
    add(TransactionCreated(transaction));

    //TODO: Verificar la edicion de un transaction a transfer

    // Do this if TRANSFER - Taking care of the second transaction
    if (formData['transaction_type'] == "transfer") {
      //Converting amount to positive
      formData['id'] = null;
      formData['amount'] = formData['amount'] * -1;
      formData['account_id'] = formData['account_id_destination'];

      // Crear objeto Transaction
      final Transaction transaction = _createTransactionFromForm(formData);
      // Emitir evento para crear o actualizar la transacción
      add(TransactionCreated(transaction));
    }
  }

//Separated function
  Transaction _createTransactionFromForm(Map<String, dynamic> formData) {
    return Transaction(
      id: formData['id'],
      accountId: formData['account_id'],
      type: formData['transaction_type'],
      amount: formData['amount'],
      categoryId: formData['category_id'] ?? 1,
      date: formData['date'] ?? DateTime.now(),
      description: formData['description'] ?? '',
    );
  }

  Future<void> _onTransactionFetchedById(
      TransactionFetchedById event, Emitter<TransactionBlocState> emit) async {}

  Future<void> _onTransactionDelete(
      TransactionDelete event, Emitter<TransactionBlocState> emit) async {
    emit(state.copyWith(isInProgress: true));

    try {
      await _repository.deleteTransaction(event.transactionId);
      final newTransactions = state.transactions;

      newTransactions
          .removeWhere((transaction) => transaction.id == event.transactionId);

      emit(state.copyWith(transactions: newTransactions, isInProgress: false));
    } catch (e) {
      emit(state.copyWith(
        isInProgress: false,
        message: 'An unexpected error occurred: ${e.toString()}',
      ));
    }
  }
}
