import 'dart:async';
import 'package:chopper/chopper.dart';
import 'package:ecommerce/models/responseHandler/brand_response.dart';
import 'package:ecommerce/models/responseHandler/product_response.dart';
import 'package:ecommerce/models/responseHandler/review_response.dart';
import '../models/responseHandler/generic_response.dart';
import '../models/responseHandler/login_response.dart';
import '../models/responseHandler/similar_product_response.dart';
import 'interceptors/custom_interceptor.dart';
import 'json_type_converter.dart';
import 'json_type_map.dart';

part 'api_service.chopper.dart';

@ChopperApi(baseUrl: "/api/v1")
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

  @GET(path: "/store/product-search")
  Future<Response<ProductResponse>> getProduct(@Query() int page, @Query() String q, @Query() int limit);

  @GET(path: "/store/product-review/product/{id}")
  Future<Response<ReviewResponse>> getProductReview(@Path('id') String id, @Query() int limit);

  @GET(path: "/store/product/{id}/similar")
  Future<Response<SimilarProductResponse>> getSimilarProduct(@Path('id') String id, @Query() int limit);

  @GET(path: "store/product/{brand}/brand")
  Future<Response<BrandResponse>> getBrand(@Path('brand') String brand);

}


class ApiProvider {
  static ApiService instance = ApiService.create("https://www.stryce.com");

}

// flutter packages pub run build_runner build --delete-conflicting-outputs
