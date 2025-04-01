import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'reports_event.dart';
part 'reports_state.dart';

class ReportsBloc extends Bloc<ReportsEvent, ReportsState> {
  ReportsBloc() : super(const ReportsState()) {
    on<ReportsPageChanged>(_onReportsPageChanged);
  }

  void _onReportsPageChanged(
    ReportsPageChanged event,
    Emitter<ReportsState> emit,
  ) {
    emit(state.copyWith(currentPage: event.pageIndex));
  }
}
