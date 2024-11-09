part of 'favorite_cubit.dart';

@immutable
sealed class FavoriteState {}

final class FavoriteInitial extends FavoriteState {}

final class GetCartLoading extends FavoriteState {}
final class GetCartSuccess extends FavoriteState {
  final List<LineVoiceModel> lineVoices;
  GetCartSuccess({required this.lineVoices});
}
final class GetCartFailure extends FavoriteState {
  final String message;
  GetCartFailure({required this.message});
}
