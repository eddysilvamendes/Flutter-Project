// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'category_model.g.dart';

@JsonSerializable()
class CategoryModel {
  String title;
  String? id;
  bool? isActive;

  @JsonKey(defaultValue: 0)
  int? pagination;

  CategoryModel({required this.title, this.id, this.pagination, this.isActive});

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);

  @override
  String toString() {
    return 'CategoryModel(title: $title, id: $id, pagination: $pagination, isActive:$isActive)';
  }
}
