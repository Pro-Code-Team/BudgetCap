import 'package:budgetcap/domain/entities/category.dart';
import 'package:budgetcap/infrastructure/models/category_model.dart';

class CategoryMapper {
  static CategoryModel toModel(Category entity) {
    return CategoryModel(
      id: entity.id,
      name: entity.name,
      icon: entity.icon,
      description: entity.description,
    );
  }

  static Category toEntity(CategoryModel model) {
    return Category(
      id: model.id,
      name: model.name,
      icon: model.icon,
      description: model.description,
    );
  }
}
