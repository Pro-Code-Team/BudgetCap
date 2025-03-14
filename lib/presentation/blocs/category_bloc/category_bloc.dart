import 'package:budgetcap/domain/entities/category.dart';
import 'package:budgetcap/infrastructure/repositories/category_repository_impl.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'category_bloc_event.dart';
part 'category_bloc_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepositoryImpl _categoryRepository;

  CategoryBloc(this._categoryRepository) : super(const CategoryState()) {
    on<CategoryInitial>(_onCategoryInitial);
    // Dispatch the CategoryInitial event when the bloc is created
    add(const CategoryInitial());
  }

  Future<void> _onCategoryInitial(
      CategoryInitial event, Emitter<CategoryState> emit) async {
    emit(state.copyWith(isInProgress: true));
    Future.delayed(
      const Duration(seconds: 1),
    );

    try {
      await _categoryRepository.getAllCategories().then((categories) {
        emit(
          state.copyWith(categories: categories, isInProgress: false),
        );
      });
    } catch (e) {
      emit(state.copyWith(message: e.toString(), isInProgress: false));
    }
  }
}
