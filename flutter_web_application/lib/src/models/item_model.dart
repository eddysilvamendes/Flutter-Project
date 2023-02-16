// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_web_application/src/models/category_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'item_model.g.dart';

@JsonSerializable()
class ItemModel {
  String? id;
  @JsonKey(name: 'title')
  String? itemName;
  @JsonKey(name: 'picture')
  String? imgUrl;
  String? unit;
  double? price;
  String? description;
  double? stock;
  bool? isActive;
  String? categoryId;
  List<CategoryModel>? category;

  ItemModel(
      {this.description,
      this.imgUrl,
      this.itemName,
      this.price,
      this.unit,
      this.id = '',
      this.stock,
      this.isActive,
      this.categoryId,
      this.category});

  factory ItemModel.fromJson(Map<String, dynamic> json) =>
      _$ItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$ItemModelToJson(this);

  @override
  String toString() {
    return 'ItemModel(id: $id, itemName: $itemName, imgUrl: $imgUrl, unit: $unit, price: $price, description: $description, isActive:$isActive, stock:$stock, categoryID:$categoryId, category:$category)';
  }
}
