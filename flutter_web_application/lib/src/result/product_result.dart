import 'package:freezed_annotation/freezed_annotation.dart';
part 'product_result.freezed.dart';

@freezed
class ProductResult<T> with _$ProductResult<T> {
  factory ProductResult.success(T data) = Success;
  factory ProductResult.error(String message) = Error;
  factory ProductResult.getSuccess(List<T> gdata) = GetSuccess;
}
