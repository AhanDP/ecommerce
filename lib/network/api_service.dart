import 'dart:async';
import 'package:chopper/chopper.dart';
import '../models/api/generic_response.dart';
import '../models/api/login_response.dart';
import 'interceptors/custom_interceptor.dart';
import 'json_type_converter.dart';
import 'json_type_map.dart';

part 'api_service.chopper.dart';

@ChopperApi(baseUrl: "/")
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

  @GET(path: "admin/product")
  Future<Response<GenericResponse>> getProduct(@Query() Map<String, dynamic> data);

  @POST(path: "admin/auth/login")
  Future<Response<LoginResponse>> login(@Body() Map<String, dynamic> data);

}


class ApiProvider {
  static ApiService instance = ApiService.create("https://bb3-api.ashwinsrivastava.com");

}

// flutter packages pub run build_runner build --delete-conflicting-outputs
