import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:budgetcap/infrastructure/models/category_model.dart';

part 'category_bloc_event.dart';
part 'category_bloc_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc()
      : super(CategoryState(
            categories: categories, chosenCategory: categories.first)) {
    on<CategoryChanged>((event, emit) {
      emit(state.copyWith(chosenCategory: event.selectedCategory));
    });
  }
}

//TEMP CATEGORIES

final List<Category> categories = [
  Category(
    name: 'Food',
    icon: 'fastfood',
    id: '',
    userId: '',
    type: '',
  ),
  Category(
    name: 'Transport',
    icon: 'directions_bus',
    id: '',
    userId: '',
    type: '',
  ),
  Category(
    name: 'Entertainment',
    icon: 'movie',
    id: '',
    userId: '',
    type: '',
  ),
  Category(
    name: 'Groceries',
    icon: 'shopping_cart',
    id: '',
    userId: '',
    type: '',
  ),
];
