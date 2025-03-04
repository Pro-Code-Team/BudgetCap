part of 'record_type_bloc.dart';

sealed class RecordTypeEvent {
  const RecordTypeEvent();
}

class RecordChanged extends RecordTypeEvent {
  final Enum selectedRecord;

  const RecordChanged({required this.selectedRecord});
}
