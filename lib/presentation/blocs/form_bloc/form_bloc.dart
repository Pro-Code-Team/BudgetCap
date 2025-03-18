import 'package:budgetcap/domain/entities/transaction.dart';
import 'package:budgetcap/presentation/blocs/account_bloc/account_bloc.dart';
import 'package:budgetcap/presentation/blocs/category_bloc/category_bloc.dart';
import 'package:budgetcap/presentation/blocs/date_bloc/date_picker_bloc.dart';
import 'package:budgetcap/presentation/blocs/record_type_bloc/record_type_bloc.dart';
import 'package:budgetcap/presentation/blocs/transaction_bloc/transaction_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'form_event.dart';
part 'form_state.dart';

class FormControlBloc extends Bloc<FormControlEvent, FormControlState> {
  final TransactionBloc transactionBloc;
  FormControlBloc(this.transactionBloc) : super(const FormControlState()) {
    on<FormFieldChanged>(_onFormFieldChanged);
    on<FormSubmitted>(_onFormSubmitted);
  }

  void _onFormFieldChanged(
      FormFieldChanged event, Emitter<FormControlState> emit) {
    final newFormData = Map<String, String>.from(state.formData);
    newFormData[event.fieldName] = event.value;
    final isValid = newFormData['Amount']?.isNotEmpty ?? false;
    emit(state.copyWith(formData: newFormData, isValid: isValid));
  }

  Future<void> _onFormSubmitted(
      FormSubmitted event, Emitter<FormControlState> emit) async {
    final recordTypeBloc = event.context.read<RecordTypeBloc>().state;
    final dateBloc = event.context.read<DatePickerBloc>().state;
    final accountBloc = event.context.read<AccountBloc>().state;
    final categoryBloc = event.context.read<CategoryBloc>().state;
    final formData = state.formData;

    if (formData['Amount'] == null || formData['Amount']!.isEmpty) {
      emit(state.copyWith(isValid: false, errorMessage: 'Amount is required'));
      print(state.isValid);
    } else {
      emit(state.copyWith(isValid: true, errorMessage: ''));
      print(recordTypeBloc.selectedValue.name);

      transactionBloc.add(RecordTransaction(
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
