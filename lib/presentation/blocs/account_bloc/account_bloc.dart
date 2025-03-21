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
}
