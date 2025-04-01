import 'dart:async';

import 'package:budgetcap/domain/entities/transaction.dart';
import 'package:budgetcap/infrastructure/repositories/transaction_repository_impl.dart';
import 'package:budgetcap/presentation/blocs/account_bloc/account_bloc.dart';
import 'package:budgetcap/presentation/blocs/category_bloc/category_bloc.dart';
import 'package:budgetcap/presentation/blocs/date_bloc/date_picker_bloc.dart';
import 'package:budgetcap/presentation/blocs/transaction_type_bloc/transaction_type_bloc.dart';
import 'package:flutter/material.dart';
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
    final Map<String, String> newFormData =
        Map<String, String>.from(state.formData);
    newFormData[event.fieldName] = event.fieldValue;
    emit(state.copyWith(formData: newFormData));
  }

  Future<void> _onTransactionFormSubmitted(TransactionFormSubmitted event,
      Emitter<TransactionBlocState> emit) async {
    final formData = state.formData;

    // Validar campos requeridos
    if (formData['Amount'] == null || formData['Amount']!.isEmpty) {
      emit(state.copyWith(isValid: false, message: 'Amount is required'));
      return;
    }

    if (double.tryParse(formData['Amount']!) == null) {
      emit(state.copyWith(
          isValid: false, message: 'Amount must be a valid number'));
      return;
    }

    emit(state.copyWith(isValid: true, message: ''));

    // Crear objeto Transaction
    final transaction = _createTransactionFromForm(event);

    // Emitir evento para crear o actualizar la transacción
    add(TransactionCreated(transaction));
  }

  Transaction _createTransactionFromForm(TransactionFormSubmitted event) {
    final recordTypeBloc = event.context.read<TransactionTypeBloc>().state;
    final dateBloc = event.context.read<DatePickerBloc>().state;
    final accountBloc = event.context.read<AccountBloc>().state;
    final categoryBloc = event.context.read<CategoryBloc>().state;
    final formData = state.formData;

    return Transaction(
      id: event.transactionId,
      accountId: accountBloc.accountSelected,
      type: recordTypeBloc.selectedValue.name,
      amount: double.parse(formData['Amount']!),
      categoryId: categoryBloc.categories[categoryBloc.categorySelected].id!,
      date: dateBloc.selectedDate,
      description: formData['Description'] ?? '',
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
