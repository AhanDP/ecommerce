import 'dart:async';
import 'package:chopper/chopper.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../../localStorage/local_storage.dart';
import '../../utils/constants.dart';

class CustomInterceptor implements Interceptor {

  @override
  FutureOr<Response<BodyType>> intercept<BodyType>(Chain<BodyType> chain) async{
    final connectivityResult = await Connectivity().checkConnectivity();

    bool isAvailable = !(connectivityResult.contains(ConnectivityResult.none));

    if (!isAvailable) {
      throw NetworkException(Constants.networkErrorMessage);
    }

    final request = applyHeader(chain.request, 'Authorization', 'Bearer ${LocalStorage.instance.accessToken}');

    request.headers.addAll({
      'Content-Type': 'application/json',
    });

    final response = await chain.proceed(request);

    return response;
  }
}

class NetworkException implements Exception {
  String error;
  NetworkException(this.error);
}