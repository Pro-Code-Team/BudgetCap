import 'dart:async';

import 'package:budgetcap/domain/entities/transaction.dart';
import 'package:budgetcap/infrastructure/repositories/transaction_repository_impl.dart';
import 'package:budgetcap/presentation/blocs/account_bloc/account_bloc.dart';
import 'package:budgetcap/presentation/blocs/category_bloc/category_bloc.dart';
import 'package:budgetcap/presentation/blocs/date_bloc/date_picker_bloc.dart';
import 'package:budgetcap/presentation/blocs/record_type_bloc/record_type_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:equatable/equatable.dart';

part 'transaction_bloc_event.dart';
part 'transaction_bloc_state.dart';

class TransactionBloc extends Bloc<TransactionBlocEvent, TransactionBlocState> {
  final TransactionRepositoryImpl _repository;

  TransactionBloc(this._repository) : super(const TransactionBlocState()) {
    on<RecordTransaction>(_onRecordTransaction);
    on<GetAllTransactions>(_onGetAllTransactions);
    on<FormFieldChanged>(_onFormFieldChanged);
    on<FormSubmitted>(_onFormSubmitted);
  }

  Future<void> _onRecordTransaction(
      RecordTransaction event, Emitter<TransactionBlocState> emit) async {
    emit(state.copyWith(isInProgress: true));
    try {
      await _repository.recordTransaction(event.transaction);
      emit(state.copyWith(isInProgress: false));
    } catch (e) {
      emit(state.copyWith(isInProgress: false, message: e.toString()));
    }
  }

  Future<void> _onGetAllTransactions(
      GetAllTransactions event, Emitter<TransactionBlocState> emit) async {
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
  void _onFormFieldChanged(
      FormFieldChanged event, Emitter<TransactionBlocState> emit) {
    final newFormData = Map<String, String>.from(state.formData);
    newFormData[event.fieldName] = event.fieldValue;
    emit(state.copyWith(formData: newFormData));
  }

  Future<void> _onFormSubmitted(
      FormSubmitted event, Emitter<TransactionBlocState> emit) async {
    final recordTypeBloc = event.context.read<RecordTypeBloc>().state;
    final dateBloc = event.context.read<DatePickerBloc>().state;
    final accountBloc = event.context.read<AccountBloc>().state;
    final categoryBloc = event.context.read<CategoryBloc>().state;
    final formData = state.formData;

    if (formData['Amount'] == null || formData['Amount']!.isEmpty) {
      emit(state.copyWith(isValid: false, message: 'Amount is required'));
      print(state.isValid);
    } else {
      emit(state.copyWith(isValid: true, message: ''));
      print(recordTypeBloc.selectedValue.name);

      add(RecordTransaction(
        Transaction(
            accountId: accountBloc.accountSelected,
            type: recordTypeBloc.selectedValue.name,
            amount: double.parse(formData['Amount']!),
            categoryId:
                categoryBloc.categories[categoryBloc.categorySelected].id!,
            date: dateBloc.selectedDate,
            description: formData['Description'] ?? ''),
      ));
    }
  }
}
