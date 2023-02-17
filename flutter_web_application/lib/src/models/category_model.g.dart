// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryModel _$CategoryModelFromJson(Map<String, dynamic> json) =>
    CategoryModel(
      title: json['title'] as String,
      id: json['id'] as String?,
      pagination: json['pagination'] as int? ?? 0,
      isActive: json['isActive'] as bool?,
    );

Map<String, dynamic> _$CategoryModelToJson(CategoryModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'id': instance.id,
      'isActive': instance.isActive,
      'pagination': instance.pagination,
    };
