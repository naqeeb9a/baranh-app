import 'package:hive/hive.dart';

// part 'menu_model.g.dart';

@HiveType(typeId: 0)
class MenuModel extends HiveObject {
  @HiveField(0)
  late int foodItemId;

  @HiveField(1)
  late int foodCode;

  @HiveField(2)
  late String foodName;

  @HiveField(3)
  late String foodCategory;

  @HiveField(4)
  late int salePrice;

  @HiveField(5)
  late int outletId;

  @HiveField(6)
  late int delStatus;

  @HiveField(7)
  late int itemImage;

  @HiveField(8)
  late int itemSection;

  @HiveField(9)
  late int syncStatus;

  @HiveField(10)
  late int isFoodItem;
}
