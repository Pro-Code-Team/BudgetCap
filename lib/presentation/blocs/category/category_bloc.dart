import 'package:budgetcap/domain/entities/category.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

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
  Category(
    name: 'Home',
    icon: 'home',
    id: '',
    userId: '',
    type: '',
  ),
  Category(
    name: 'Car',
    icon: 'directions_car',
    id: '',
    userId: '',
    type: '',
  ),
  Category(
    name: 'Health',
    icon: 'local_hospital',
    id: '',
    userId: '',
    type: '',
  ),
  Category(
    name: 'Education',
    icon: 'school',
    id: '',
    userId: '',
    type: '',
  ),
  Category(
    name: 'Travel',
    icon: 'airplanemode_active',
    id: '',
    userId: '',
    type: '',
  ),
  Category(
    name: 'Utilities',
    icon: 'lightbulb',
    id: '',
    userId: '',
    type: '',
  ),
  Category(
    name: 'Phone',
    icon: 'phone',
    id: '',
    userId: '',
    type: '',
  ),
  Category(
    name: 'Internet',
    icon: 'wifi',
    id: '',
    userId: '',
    type: '',
  ),
  // Additional categories
  Category(
    name: 'Clothing',
    icon: 'shopping_bag',
    id: '',
    userId: '',
    type: '',
  ),
  Category(
    name: 'Savings',
    icon: 'savings',
    id: '',
    userId: '',
    type: '',
  ),
  Category(
    name: 'Gift',
    icon: 'card_giftcard',
    id: '',
    userId: '',
    type: '',
  ),
  Category(
    name: 'Insurance',
    icon: 'security',
    id: '',
    userId: '',
    type: '',
  ),
  Category(
    name: 'Pets',
    icon: 'pets',
    id: '',
    userId: '',
    type: '',
  ),
  Category(
    name: 'Restaurant',
    icon: 'restaurant',
    id: '',
    userId: '',
    type: '',
  ),
  Category(
    name: 'Fitness',
    icon: 'fitness_center',
    id: '',
    userId: '',
    type: '',
  ),
  Category(
    name: 'Beauty',
    icon: 'brush',
    id: '',
    userId: '',
    type: '',
  ),
];
