import 'package:hive/hive.dart';

// part 'menu_model.g.dart';

@HiveType(typeId: 0)
class MenuModel extends HiveObject {
  @HiveField(0)
  late int foodMenuId;

  @HiveField(1)
  late int foodCode;

  @HiveField(2)
  late String foodName;

  @HiveField(3)
  late String foodCategory;

  @HiveField(4)
  late int salePrice;

  @HiveField(5)
  late int totalIngredients;
}
