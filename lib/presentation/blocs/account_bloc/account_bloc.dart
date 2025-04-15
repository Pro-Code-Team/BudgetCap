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
    on<AccountFormFieldChanged>(_onFormFieldChanged);
    on<AccountFormSubmitted>(_onFormSubmitted);
    on<AccountFormInitializedValues>(_onFormInitializedValues);

    add(const AccountInitial());
  }

  void _onAccountSelected(AccountSelected event, Emitter<AccountState> emit) {
    emit(state.copyWith(accountSelected: event.accountSelected));
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

  void _onFormInitializedValues(
      AccountFormInitializedValues event, Emitter<AccountState> emit) {
    emit(state.copyWith(
      formData: event.formData,
      isInProgress: false,
      isSuccess: false,
      message: '',
    ));
  }

  Future<void> _onAccountInitial(
      AccountInitial event, Emitter<AccountState> emit) async {
    emit(state.copyWith(isInProgress: true, isSuccess: false, message: ''));
    try {
      emit(
        state.copyWith(
          accounts: await _accountRepo.getAllAccounts(),
          isInProgress: false,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isInProgress: false, message: e.toString()));
    }
  }

  //FORM EVENTS
  void _onFormFieldChanged(
      AccountFormFieldChanged event, Emitter<AccountState> emit) {
    final newFormData = Map<String, String>.from(state.formData);
    newFormData[event.fieldName] = event.fieldValue;
    emit(state.copyWith(formData: newFormData));
  }

  Future<void> _onFormSubmitted(
      AccountFormSubmitted event, Emitter<AccountState> emit) async {
    final Map<String, String> formData = state.formData;

    // Emit loading state
    emit(state.copyWith(isInProgress: true));

    try {
      // Call the repository to add the account
      final int accountId = await _accountRepo.addAccount(
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
      if (accountId > 0) {
        emit(
          state.copyWith(
            isInProgress: false,
            isSuccess: true,
            message: 'The account has been created successfully!',
          ),
        );
        add(const AccountInitial());
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
