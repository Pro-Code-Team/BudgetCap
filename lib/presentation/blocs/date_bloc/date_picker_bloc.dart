import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'date_picker_event.dart';
part 'date_picker_state.dart';

class DatePickerBloc extends Bloc<DatePickerEvent, DatePickerState> {
  DatePickerBloc() : super(DatePickerState()) {
    //
    on<DateChanged>((event, emit) {
      emit(state.copyWith(selectedDate: event.selectedDate));
    });
  }
}
