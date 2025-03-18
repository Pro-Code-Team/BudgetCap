part of 'category_bloc.dart';

class CategoryState extends Equatable {
  final int categorySelected;
  final bool isInProgress;
  final String message;
  final List<Category> categories;

  const CategoryState(
      {this.categorySelected = -1,
      this.message = '',
      this.isInProgress = false,
      this.categories = const []});

  CategoryState copyWith({
    bool? isInProgress,
    String? message,
    List<Category>? categories,
    int? categorySelected,
  }) {
    return CategoryState(
      isInProgress: isInProgress ?? this.isInProgress,
      message: message ?? this.message,
      categories: categories ?? this.categories,
      categorySelected: categorySelected ?? this.categorySelected,
    );
  }

  @override
  List<Object> get props =>
      [categories, message, isInProgress, categorySelected];
}
