import 'package:budgetcap/presentation/screens/transaction/transaction_screen.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'transaction_type_event.dart';
part 'transaction_type_state.dart';

class TransactionTypeBloc
    extends Bloc<TransactionTypeEvent, TransactionTypeState> {
  TransactionTypeBloc() : super(const TransactionTypeState()) {
    //
    on<TransactionChanged>((event, emit) {
      emit(state.copyWith(selectedValue: event.selectedRecord));
    });
  }
}
