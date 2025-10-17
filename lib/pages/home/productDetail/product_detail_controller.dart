import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ProductDetailState {}

class ProductDetailInit extends ProductDetailState {}
class ProductDetailLoading extends ProductDetailState {}
class ProductDetailFailed extends ProductDetailState {final String error;ProductDetailFailed(this.error);}
class ProductDetailLoaded extends ProductDetailState {}

class ProductDetailBloc extends Cubit<ProductDetailState> {

  ProductDetailBloc() : super(ProductDetailInit());
}
