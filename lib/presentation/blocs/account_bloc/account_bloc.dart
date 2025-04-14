import 'package:budgetcap/domain/entities/account.dart';
import 'package:budgetcap/infrastructure/repositories/account_repository_impl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final AccountRepositoryImpl _accountRepo;

  AccountBloc(this._accountRepo) : super(const AccountState()) {
    on<AccountSelected>(_onAccountSelected);
    on<AccountInitial>(_onAccountInitial);
    on<RecordAccount>(_onRecordAccount);
    on<FormFieldChanged>(_onFormFieldChanged);
    on<FormSubmitted>(_onFormSubmitted);
    on<AccountToBeTransferredSelected>(_onAccountToBeTransferredSelected);

    add(const AccountInitial());
  }

  void _onAccountSelected(AccountSelected event, Emitter<AccountState> emit) {
    emit(state.copyWith(accountSelected: event.accountSelected));
  }

  void _onAccountToBeTransferredSelected(
      AccountToBeTransferredSelected event, Emitter<AccountState> emit) {
    emit(state.copyWith(
        accountToBeTransferred: event.accountToBeTransferredSelected));
  }

  Future<void> _onRecordAccount(
      RecordAccount event, Emitter<AccountState> emit) async {
    emit(state.copyWith(isInProgress: true));
    try {
      await _accountRepo.addAccount(event.account);
      emit(state.copyWith(isInProgress: false));
    } catch (e) {
      emit(state.copyWith(isInProgress: false, message: e.toString()));
    }
  }

  Future<void> _onAccountInitial(
      AccountInitial event, Emitter<AccountState> emit) async {
    try {
      emit(
        state.copyWith(
          accounts: await _accountRepo.getAllAccounts(),
        ),
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  //FORM EVENTS
  void _onFormFieldChanged(FormFieldChanged event, Emitter<AccountState> emit) {
    final newFormData = Map<String, String>.from(state.formData);
    newFormData[event.fieldName] = event.fieldValue;
    emit(state.copyWith(formData: newFormData));
  }

  Future<void> _onFormSubmitted(
      FormSubmitted event, Emitter<AccountState> emit) async {
    final formData = state.formData;

    // Emit loading state
    emit(state.copyWith(isInProgress: true, message: '', isSuccess: false));

    try {
      // Call the repository to add the account
      final String response = await _accountRepo.addAccount(
        Account(
          name: formData['name']!.toUpperCase(),
          description: formData['description']!,
          currency: formData['currency']!,
          balance: 0.0,
          icon: formData['icon']!,
          color: formData['color']!,
        ),
      );

      // Emit success state if the response is valid
      if (response.isNotEmpty) {
        emit(
          state.copyWith(
            isInProgress: false,
            isSuccess: true,
            message: 'The account has been created successfully!',
            accounts: await _accountRepo.getAllAccounts(),
          ),
        );
        emit(state.copyWith(isSuccess: false));
      } else {
        // Emit failure state if the response is empty
        emit(state.copyWith(
          isInProgress: false,
          isSuccess: false,
          message: 'Failed to create the account. Please try again.',
        ));
      }
    } catch (e) {
      // Emit failure state if an exception occurs
      emit(state.copyWith(
        isInProgress: false,
        isSuccess: false,
        message: 'An error occurred: ${e.toString()}',
      ));
    }
  }
}
