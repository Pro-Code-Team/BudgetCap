part of 'category_bloc.dart';

sealed class CategoryEvent {
  const CategoryEvent();
}

class CategoryInitial extends CategoryEvent {
  const CategoryInitial();
}

class CategoryChanged extends CategoryEvent {
  final int categorySelected;

  CategoryChanged({required this.categorySelected});
}
