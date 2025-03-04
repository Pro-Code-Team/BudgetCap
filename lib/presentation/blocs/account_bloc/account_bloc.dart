import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc()
      : super(AccountState(
            accounts: ['Ficohsa', 'BAC', 'Banpro', 'LAFISE', 'Atlantida'])) {
    on<AccountSelected>((event, emit) {
      emit(state.copyWith(selectedAccount: event.account));
    });
  }
}
