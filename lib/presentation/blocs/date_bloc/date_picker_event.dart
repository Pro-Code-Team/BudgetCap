part of 'date_picker_bloc.dart';

sealed class DatePickerEvent {
  const DatePickerEvent();
}

class DateChanged extends DatePickerEvent {
  final DateTime selectedDate;

  const DateChanged({required this.selectedDate});
}
