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

    try {
      if (isEditMode) {
        await _repository.updateTransaction(event.transaction);
        final newTransactions = state.transactions;
        //Finding index of the updated transaction.
        newTransactions[newTransactions.indexWhere(
                (transaction) => transaction.id == event.transaction.id)] =
            event.transaction;

        emit(state.copyWith(isInProgress: false));
      } else {
        await _repository.recordTransaction(event.transaction);
        final newTransactions = state.transactions;
        newTransactions.add(event.transaction);
        emit(
            state.copyWith(transactions: newTransactions, isInProgress: false));
      }
    } catch (e) {
      emit(state.copyWith(isInProgress: false, message: e.toString()));
    }
  }

  Future<void> _onTransactionFetchAll(
      TransactionFetchAll event, Emitter<TransactionBlocState> emit) async {
    emit(state.copyWith(isInProgress: true));
    try {
      emit(
          state.copyWith(transactions: await _repository.getAllTransactions()));
      emit(state.copyWith(isInProgress: false));
    } catch (e) {
      emit(state.copyWith(isInProgress: false, message: e.toString()));
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
    final recordTypeBloc = event.context.read<TransactionTypeBloc>().state;
    final dateBloc = event.context.read<DatePickerBloc>().state;
    final accountBloc = event.context.read<AccountBloc>().state;
    final categoryBloc = event.context.read<CategoryBloc>().state;
    final formData = state.formData;

    if (formData['Amount'] == null || formData['Amount']!.isEmpty) {
      emit(state.copyWith(isValid: false, message: 'Amount is required'));
    } else {
      emit(state.copyWith(isValid: true, message: ''));

      final int? transactionId = event.transactionId;
      final id = transactionId;
      final accountId = accountBloc.accountSelected;
      final type = recordTypeBloc.selectedValue.name;
      final amount = double.parse(formData['Amount']!);
      final categoryId =
          categoryBloc.categories[categoryBloc.categorySelected].id!;
      final date = dateBloc.selectedDate;
      final description = formData['Description'] ?? '';

      add(
        TransactionCreated(
          transactionId != null
              ? Transaction(
                  id: id,
                  accountId: accountId,
                  type: type,
                  amount: amount,
                  categoryId: categoryId,
                  date: date,
                  description: description,
                )
              : Transaction(
                  accountId: accountId,
                  type: type,
                  amount: amount,
                  categoryId: categoryId,
                  date: date,
                  description: description,
                ),
        ),
      );
    }
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
      emit(state.copyWith(isInProgress: false, message: e.toString()));
    }
  }
}
