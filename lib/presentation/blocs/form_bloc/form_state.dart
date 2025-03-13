part of 'form_bloc.dart';

class FormControlState extends Equatable {
  final Map<String, String> formData;
  final bool isValid;
  final String errorMessage;

  const FormControlState(
      {this.formData = const {}, this.isValid = false, this.errorMessage = ''});

  FormControlState copyWith({
    Map<String, String>? formData,
    bool? isValid,
    String? errorMessage,
  }) {
    return FormControlState(
      formData: formData ?? this.formData,
      isValid: isValid ?? this.isValid,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [formData, isValid, errorMessage];
}
