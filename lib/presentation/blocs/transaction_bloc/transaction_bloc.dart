import 'package:budgetcap/domain/entities/transaction.dart';
import 'package:budgetcap/infrastructure/repositories/transaction_repository_impl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:equatable/equatable.dart';

part 'transaction_bloc_event.dart';
part 'transaction_bloc_state.dart';

class TransactionBloc extends Bloc<TransactionBlocEvent, TransactionBlocState> {
  final TransactionRepositoryImpl repo;

  TransactionBloc({required this.repo}) : super(const TransactionBlocState()) {
    on<RecordTransaction>((event, emit) async {
      emit(state.copyWith(isInProgress: true));
      try {
        await repo.recordTransaction(event.transaction);
        emit(state.copyWith(isInProgress: false));
      } catch (e) {
        emit(state.copyWith(isInProgress: false, message: e.toString()));
      }
    });
  }
}
