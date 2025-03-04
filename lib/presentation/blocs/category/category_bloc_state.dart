part of 'category_bloc.dart';

class CategoryState extends Equatable {
  final Category chosenCategory;
  final List<Category> categories;

  const CategoryState({required this.chosenCategory, required this.categories});

  CategoryState copyWith({
    Category? chosenCategory,
    List<Category>? categories,
  }) {
    return CategoryState(
      chosenCategory: chosenCategory ?? this.chosenCategory,
      categories: categories ?? this.categories,
    );
  }

  @override
  List<Object> get props => [chosenCategory, categories];
}
