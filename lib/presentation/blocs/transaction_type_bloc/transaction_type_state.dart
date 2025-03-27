part of 'transaction_type_bloc.dart';

class TransactionTypeState extends Equatable {
  final Enum selectedValue;

  const TransactionTypeState({Enum? selectedValue})
      : selectedValue = selectedValue ?? Operations.income;

  TransactionTypeState copyWith({
    Enum? selectedValue,
  }) {
    return TransactionTypeState(
      selectedValue: selectedValue ?? this.selectedValue,
    );
  }

  @override
  List<Object> get props => [selectedValue];
}
