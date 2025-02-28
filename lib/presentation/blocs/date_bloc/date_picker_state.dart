part of 'date_picker_bloc.dart';

class DatePickerState extends Equatable {
  final DateTime selectedDate;

  DatePickerState({DateTime? selectedDate})
      : selectedDate = selectedDate ?? DateTime.now();

  DatePickerState copyWith({
    DateTime? selectedDate,
  }) {
    return DatePickerState(
      selectedDate: selectedDate ?? this.selectedDate,
    );
  }

  @override
  List<Object> get props => [selectedDate];
}
