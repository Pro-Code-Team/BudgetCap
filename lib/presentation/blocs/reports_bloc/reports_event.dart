part of 'reports_bloc.dart';

sealed class ReportsEvent {
  const ReportsEvent();
}

class ReportsPageChanged extends ReportsEvent {
  final int pageIndex;

  const ReportsPageChanged(this.pageIndex);
}
