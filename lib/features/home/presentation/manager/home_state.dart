part of 'home_cubit.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}
final class HomeLoadingState extends HomeState {}
final class HomeSuccessState extends HomeState {
  final List<CategoryModel> categories;
  HomeSuccessState(this.categories);
}
final class HomeErrorState extends HomeState {}
