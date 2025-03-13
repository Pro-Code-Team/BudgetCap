part of 'form_bloc.dart';

sealed class FormControlEvent {
  const FormControlEvent();
}

class FormFieldChanged extends FormControlEvent {
  final String value;
  final String fieldName;

  const FormFieldChanged({
    required this.value,
    required this.fieldName,
  });
}

class FormSubmitted extends FormControlEvent {
  final Map<String, String> formData;

  FormSubmitted({required this.formData});
}
