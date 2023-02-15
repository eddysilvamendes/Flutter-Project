import 'package:freezed_annotation/freezed_annotation.dart';
part 'category_result.freezed.dart';

@freezed
class CategoryResult<T> with _$CategoryResult<T> {
  factory CategoryResult.success(List<T> data) = Success;
  factory CategoryResult.error(String message) = Error;
}
