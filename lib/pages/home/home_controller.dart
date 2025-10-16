// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:sterna_manage/models/truck_vts.dart';
// import '../../../network/api_service.dart';
// import '../../../network/interceptors/custom_interceptor.dart';
//
// abstract class TruckVtsState {}
//
// class TruckVtsInit extends TruckVtsState {}
//
// class TruckVtsLoading extends TruckVtsState {}
//
// class TruckVtsMoreLoading extends TruckVtsState {}
//
// class TruckVtsFailed extends TruckVtsState {
//   final String error;
//
//   TruckVtsFailed(this.error);
// }
//
// class TruckVtsLoaded extends TruckVtsState {}
//
// class TruckVtsBloc extends Cubit<TruckVtsState> {
//   List<TruckVts> truckVtsData = [];
//   ScrollController? scrollController;
//   int page = 1;
//   bool isLoadNextPage = true;
//   TextEditingController searchController = TextEditingController();
//
//   TruckVtsBloc() : super(TruckVtsInit());
//
//   void refreshData() {
//     page = 1;
//     truckVtsData = [];
//     isLoadNextPage = true;
//   }
//
//   void listenScrollEvent() {
//     page = 1;
//     isLoadNextPage = true;
//     truckVtsData = [];
//     scrollController = ScrollController();
//     scrollController?.addListener(() {
//       if (scrollController?.position.maxScrollExtent ==
//           scrollController?.offset) {
//         if (isLoadNextPage) {
//           page++;
//           fetchMoreTruckVts();
//         }
//       }
//     });
//   }
//
//   void setIsNextPage(List<TruckVts> items) {
//     if (items.length < 10) {
//       isLoadNextPage = false;
//     } else {
//       isLoadNextPage = true;
//     }
//   }
//
//   Future<void> fetchTruckVts(String? val) async {
//     if(val == null || val == '') {
//       searchController.clear();
//       emit(TruckVtsLoading());
//     }
//     refreshData();
//     try {
//       final response = await ApiProvider.instance.fetchTruckVts(page, searchController.text);
//       bool status = response.statusCode == 200 || response.statusCode == 201;
//       if (status) {
//         truckVtsData = response.body?.truckVtsData?.truckVts ?? [];
//         setIsNextPage(truckVtsData);
//         emit(TruckVtsLoaded());
//       } else {
//         emit(TruckVtsFailed(response.error.toString()));
//       }
//     } on NetworkException {
//       emit(TruckVtsFailed("No internet connection"));
//     } catch (e) {
//       emit(TruckVtsFailed(e.toString()));
//     }
//   }
//
//   Future<void> fetchMoreTruckVts() async {
//     emit(TruckVtsMoreLoading());
//     try {
//       final response = await ApiProvider.instance.fetchTruckVts(page, searchController.text);
//       bool status = response.statusCode == 200 || response.statusCode == 201;
//       if (status) {
//         var truckVts = response.body?.truckVtsData?.truckVts ?? [];
//         truckVtsData.addAll(truckVts);
//         setIsNextPage(truckVts);
//         emit(TruckVtsLoaded());
//       } else {
//         emit(TruckVtsFailed(response.error.toString()));
//       }
//     } on NetworkException {
//       emit(TruckVtsFailed("No internet connection"));
//     } catch (e) {
//       emit(TruckVtsFailed(e.toString()));
//     }
//   }
// }
