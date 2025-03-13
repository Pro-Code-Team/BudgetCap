import 'package:budgetcap/domain/entities/transaction.dart';
import 'package:budgetcap/presentation/blocs/transaction_bloc/transaction_bloc.dart';
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
    final formData = state.formData;

    if (formData['Amount'] == null || formData['Amount']!.isEmpty) {
      emit(state.copyWith(isValid: false, errorMessage: 'Amount is required'));
      print(state.isValid);
    } else {
      emit(state.copyWith(isValid: true, errorMessage: ''));
      print(formData);
      transactionBloc.add(RecordTransaction(
        Transaction(
            id: 1,
            accountId: 1,
            type: 'Income',
            amount: double.parse(formData['Amount']!),
            categoryId: 1,
            date: DateTime.now(),
            description: formData['Description'] ?? ''),
      ));
    }
  }
}
