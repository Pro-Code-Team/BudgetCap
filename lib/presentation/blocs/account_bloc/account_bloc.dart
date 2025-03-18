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
    add(const AccountInitial());
  }

  void _onAccountSelected(AccountSelected event, Emitter<AccountState> emit) {
    emit(state.copyWith(accountSelected: event.accountSelected));
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
