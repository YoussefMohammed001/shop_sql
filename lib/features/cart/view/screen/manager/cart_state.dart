part of 'cart_cubit.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

 class CheckOutSuccessState extends CartState {}
 class CheckOutErrorState extends CartState {}
