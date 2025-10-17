import 'dart:async';
import 'package:chopper/chopper.dart';
import 'package:ecommerce/models/responseHandler/product_response.dart';
import '../models/responseHandler/generic_response.dart';
import '../models/responseHandler/login_response.dart';
import 'interceptors/custom_interceptor.dart';
import 'json_type_converter.dart';
import 'json_type_map.dart';

part 'api_service.chopper.dart';

@ChopperApi(baseUrl: "/api")
abstract class ApiService extends ChopperService {
  static ApiService create(String baseUrl) {
    final chopperClient = ChopperClient(
        baseUrl: Uri.parse(baseUrl),
        services: [_$ApiService()],
        interceptors: [
          HttpLoggingInterceptor(),
          CustomInterceptor(),
        ],
        converter: JsonSerializableConverter(type2JsonMap),
        errorConverter: const JsonSerializableConverter({GenericResponse: GenericResponse.fromJson}),
    );
    return _$ApiService(chopperClient);
  }

  @POST(path: "/admin/auth/login")
  Future<Response<LoginResponse>> login(@Body() Map<String, dynamic> data);

  @GET(path: "/v1/store/product-search")
  Future<Response<ProductResponse>> getProduct(@Query() String page, @Query() q, @);

}


class ApiProvider {
  static ApiService instance = ApiService.create("https://www.stryce.com");

}

// flutter packages pub run build_runner build --delete-conflicting-outputs
