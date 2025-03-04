part of 'record_type_bloc.dart';

class RecordTypeState extends Equatable {
  final Enum selectedValue;

  RecordTypeState({Enum? selectedValue})
      : selectedValue = selectedValue ?? Operations.income;

  RecordTypeState copyWith({
    Enum? selectedValue,
  }) {
    return RecordTypeState(
      selectedValue: selectedValue ?? this.selectedValue,
    );
  }

  @override
  List<Object> get props => [selectedValue];
}
