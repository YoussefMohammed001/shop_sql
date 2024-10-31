part of 'favorite_cubit.dart';

@immutable
sealed class FavoriteState {}

final class FavoriteInitial extends FavoriteState {}

final class FavoriteLoading extends FavoriteState {}
final class FavoriteSuccess extends FavoriteState {
  final List<CategoryModel> notes;
  FavoriteSuccess({required this.notes});
}
final class FavoriteFailure extends FavoriteState {
  final String message;
  FavoriteFailure({required this.message});
}
