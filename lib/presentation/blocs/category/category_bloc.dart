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
      name: 'Food', icon: 'fastfood', id: '', description: 'Food and drinks'),
  Category(
      name: 'Transport',
      icon: 'directions_bus',
      id: '',
      description: 'Food and drinks'),
  Category(
      name: 'Entertainment',
      icon: 'movie',
      id: '',
      description: 'Food and drinks'),
  Category(
      name: 'Groceries',
      icon: 'shopping_cart',
      id: '',
      description: 'Food and drinks'),
  Category(name: 'Home', icon: 'home', id: '', description: 'Food and drinks'),
  Category(
      name: 'Car',
      icon: 'directions_car',
      id: '',
      description: 'Food and drinks'),
  Category(
      name: 'Health',
      icon: 'local_hospital',
      id: '',
      description: 'Food and drinks'),
  Category(
      name: 'Education',
      icon: 'school',
      id: '',
      description: 'Food and drinks'),
  Category(
      name: 'Travel',
      icon: 'airplanemode_active',
      id: '',
      description: 'Food and drinks'),
  Category(
      name: 'Utilities',
      icon: 'lightbulb',
      id: '',
      description: 'Food and drinks'),
  Category(
      name: 'Phone', icon: 'phone', id: '', description: 'Food and drinks'),
  Category(
      name: 'Internet', icon: 'wifi', id: '', description: 'Food and drinks'),
  // Additional categories
  Category(
      name: 'Clothing',
      icon: 'shopping_bag',
      id: '',
      description: 'Food and drinks'),
  Category(
      name: 'Savings', icon: 'savings', id: '', description: 'Food and drinks'),
  Category(
      name: 'Gift',
      icon: 'card_giftcard',
      id: '',
      description: 'Food and drinks'),
  Category(
      name: 'Insurance',
      icon: 'security',
      id: '',
      description: 'Food and drinks'),
  Category(name: 'Pets', icon: 'pets', id: '', description: 'Food and drinks'),
  Category(
      name: 'Restaurant',
      icon: 'restaurant',
      id: '',
      description: 'Food and drinks'),
  Category(
      name: 'Fitness',
      icon: 'fitness_center',
      id: '',
      description: 'Food and drinks'),
  Category(
      name: 'Beauty', icon: 'brush', id: '', description: 'Food and drinks'),
];
