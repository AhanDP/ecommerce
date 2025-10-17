import 'package:ecommerce/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../network/api_service.dart';
import '../../../network/interceptors/custom_interceptor.dart';

abstract class TruckVtsState {}

class TruckVtsInit extends TruckVtsState {}

class TruckVtsLoading extends TruckVtsState {}

class TruckVtsMoreLoading extends TruckVtsState {}

class TruckVtsFailed extends TruckVtsState {
  final String error;

  TruckVtsFailed(this.error);
}

class TruckVtsLoaded extends TruckVtsState {}

class TruckVtsBloc extends Cubit<TruckVtsState> {
  List<Product> products = [];
  ScrollController? scrollController;
  int page = 1;
  bool isLoadNextPage = true;
  TextEditingController searchController = TextEditingController();

  TruckVtsBloc() : super(TruckVtsInit());

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
          fetchMoreTruckVts();
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

  Future<void> fetchTruckVts(String? val) async {
    if(val == null || val == '') {
      searchController.clear();
      emit(TruckVtsLoading());
    }
    refreshData();
    try {
      final response = await ApiProvider.instance.getProduct(page, searchController.text);
      bool status = response.statusCode == 200 || response.statusCode == 201;
      if (status) {
        products = response.body?.products?.truckVts ?? [];
        setIsNextPage(products);
        emit(TruckVtsLoaded());
      } else {
        emit(TruckVtsFailed(response.error.toString()));
      }
    } on NetworkException {
      emit(TruckVtsFailed("No internet connection"));
    } catch (e) {
      emit(TruckVtsFailed(e.toString()));
    }
  }

  Future<void> fetchMoreTruckVts() async {
    emit(TruckVtsMoreLoading());
    try {
      final response = await ApiProvider.instance.fetchTruckVts(page, searchController.text);
      bool status = response.statusCode == 200 || response.statusCode == 201;
      if (status) {
        var truckVts = response.body?.products?.truckVts ?? [];
        products.addAll(truckVts);
        setIsNextPage(truckVts);
        emit(TruckVtsLoaded());
      } else {
        emit(TruckVtsFailed(response.error.toString()));
      }
    } on NetworkException {
      emit(TruckVtsFailed("No internet connection"));
    } catch (e) {
      emit(TruckVtsFailed(e.toString()));
    }
  }
}
