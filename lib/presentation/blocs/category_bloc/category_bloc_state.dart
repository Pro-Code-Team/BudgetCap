part of 'category_bloc.dart';

class CategoryState extends Equatable {
  final bool isInProgress;
  final String message;
  final List<Category> categories;

  const CategoryState(
      {this.message = '',
      this.isInProgress = false,
      this.categories = const []});

  CategoryState copyWith({
    bool? isInProgress,
    String? message,
    List<Category>? categories,
  }) {
    return CategoryState(
      isInProgress: isInProgress ?? this.isInProgress,
      message: message ?? this.message,
      categories: categories ?? this.categories,
    );
  }

  @override
  List<Object> get props => [categories, message, isInProgress];
}
