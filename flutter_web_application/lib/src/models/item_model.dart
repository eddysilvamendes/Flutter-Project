// ignore_for_file: public_member_api_docs, sort_constructors_first
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

  ItemModel(
      {this.description,
      this.imgUrl,
      this.itemName,
      this.price,
      this.unit,
      this.id = '',
      this.stock,
      this.isActive,
      this.categoryId});

  factory ItemModel.fromJson(Map<String, dynamic> json) =>
      _$ItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$ItemModelToJson(this);

  @override
  String toString() {
    return 'ItemModel(id: $id, itemName: $itemName, imgUrl: $imgUrl, unit: $unit, price: $price, description: $description, isSelling:$isActive, stock:$stock, category$categoryId)';
  }
}
