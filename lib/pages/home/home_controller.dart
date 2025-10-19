import 'package:ecommerce/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../network/api_service.dart';
import '../../network/api_call_handler.dart';

abstract class HomeState {}

class HomeInit extends HomeState {}
class HomeLoading extends HomeState {}
class HomeMoreLoading extends HomeState {}
class HomeFailed extends HomeState {final String error;HomeFailed(this.error);}
class HomeLoaded extends HomeState {}

class HomeBloc extends Cubit<HomeState> {
  List<Product> products = [];
  ScrollController? scrollController;
  int page = 1;
  bool isLoadNextPage = true;
  TextEditingController searchController = TextEditingController();

  HomeBloc() : super(HomeInit());

  void refreshData() {
    page = 1;
    products = [];
    isLoadNextPage = true;
  }

  void listenScrollEvent() {
    page = 1;
    isLoadNextPage = true;
    products = [];
    scrollController = ScrollController();
    scrollController?.addListener(() {
      if (scrollController?.position.maxScrollExtent ==
          scrollController?.offset) {
        if (isLoadNextPage) {
          page++;
          fetchMoreProducts();
        }
      }
    });
  }

  void setIsNextPage(List<Product> items) {
    if (items.length < 10) {
      isLoadNextPage = false;
    } else {
      isLoadNextPage = true;
    }
  }

  Future<void> fetchProducts(String? val) async {
    await ApiCallHandler.call(
      apiCall: () async => await ApiProvider.instance.getProduct(page, searchController.text, 10),
      onLoading: () {
        if(val == null || val == '') {
          searchController.clear();
          emit(HomeLoading());
        }
        refreshData();
      },
      onSuccess: (response) async {
        products = response?.products ?? [];
        setIsNextPage(products);
        emit(HomeLoaded());
      },
      onFailure: (errorMsg, isNetworkError) {
        emit(HomeFailed(errorMsg));
      },
    );
  }

  Future<void> fetchMoreProducts() async {
    await ApiCallHandler.call(
      apiCall: () async => await ApiProvider.instance.getProduct(page, searchController.text, 10),
      onLoading: () => emit(HomeMoreLoading()),
      onSuccess: (response) async {
        var productList = response?.products ?? [];
        products.addAll(productList);
        setIsNextPage(productList);
        emit(HomeLoaded());
      },
      onFailure: (errorMsg, isNetworkError) {
        emit(HomeFailed(errorMsg));
      },
    );
  }

  double computeAspectRatio(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const horizontalPadding = 10.0 * 2;
    const crossAxisCount = 2;
    const crossAxisSpacing = 12.0;

    final availableWidth = size.width - horizontalPadding;
    final itemWidth = (availableWidth - (crossAxisSpacing * (crossAxisCount - 1))) / crossAxisCount;
    final itemHeight = itemWidth * 1.55;
    return itemWidth / itemHeight;
  }
}
