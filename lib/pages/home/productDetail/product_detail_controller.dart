import 'package:ecommerce/models/brand.dart';
import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/models/review.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../network/api_call_handler.dart';
import '../../../network/api_service.dart';

abstract class ProductDetailState {}

class ProductDetailInit extends ProductDetailState {}
class ProductDetailLoading extends ProductDetailState {}
class ProductDetailFailed extends ProductDetailState {final String error;ProductDetailFailed(this.error);}
class ProductDetailLoaded extends ProductDetailState {}

class ProductDetailBloc extends Cubit<ProductDetailState> {
  ProductDetailBloc() : super(ProductDetailInit());
  List<Review> reviews = [];
  Brand? brand;
  int quantity = 1;
  List<Product> similarProducts = [];

  Future<void> fetchProductReview(String id) async {
    await ApiCallHandler.call(
      apiCall: () async => await ApiProvider.instance.getProductReview(id, 10),
      onLoading: () {},
      onSuccess: (response) async {
        reviews = response?.reviews ?? [];
        emit(ProductDetailLoaded());
      },
      onFailure: (errorMsg, isNetworkError) {
      },
    );
  }

  Future<void> fetchBrand(String brandHandler) async {
    await ApiCallHandler.call(
      apiCall: () async => await ApiProvider.instance.getBrand(brandHandler),
      onLoading: () {},
      onSuccess: (response) async {
        brand = response?.brand;
        emit(ProductDetailLoaded());
      },
      onFailure: (errorMsg, isNetworkError) {
      },
    );
  }

  Future<void> fetchSimilarProduct(String id) async {
    await ApiCallHandler.call(
      apiCall: () async => await ApiProvider.instance.getSimilarProduct(id, 10),
      onLoading: () {},
      onSuccess: (response) async {
        similarProducts = response?.similarProducts ?? [];
        emit(ProductDetailLoaded());
      },
      onFailure: (errorMsg, isNetworkError) {
      },
    );
  }

  void increaseQuantity() {
    quantity++;
    emit(ProductDetailLoaded());
  }

  void decreaseQuantity() {
    if (quantity > 1) {
      quantity--;
    }
    emit(ProductDetailLoaded());
  }
}
