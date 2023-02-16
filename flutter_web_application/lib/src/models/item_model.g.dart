// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemModel _$ItemModelFromJson(Map<String, dynamic> json) => ItemModel(
      description: json['description'] as String?,
      imgUrl: json['picture'] as String?,
      itemName: json['title'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      unit: json['unit'] as String?,
      id: json['id'] as String? ?? '',
      stock: (json['stock'] as num?)?.toDouble(),
      isActive: json['isActive'] as bool?,
      // categoryId: json['categoryId'] as String?,
    );

Map<String, dynamic> _$ItemModelToJson(ItemModel instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.itemName,
      'picture': instance.imgUrl,
      'unit': instance.unit,
      'price': instance.price,
      'description': instance.description,
      'stock': instance.stock,
      'isActive': instance.isActive,
      'categoryId': instance.categoryId,
    };
