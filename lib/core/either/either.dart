import 'package:freezed_annotation/freezed_annotation.dart';

part 'either.freezed.dart';

/// The `Either` class is a generic class that represents a value that can be either of type `L` or of
/// type `R`.
@freezed
class Either<L, R> with _$Either<L, R> {
  factory Either.left(L value) = _Left;
  factory Either.right(R value) = _Right;
}