import 'package:budgetcap/presentation/screens/transaction_screen.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'record_type_event.dart';
part 'record_type_state.dart';

class RecordTypeBloc extends Bloc<RecordTypeEvent, RecordTypeState> {
  RecordTypeBloc() : super(RecordTypeState()) {
    //
    on<RecordChanged>((event, emit) {
      emit(state.copyWith(selectedValue: event.selectedRecord));
    });
  }
}
