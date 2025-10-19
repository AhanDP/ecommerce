import 'package:ecommerce/models/responseHandler/brand_response.dart';
import 'package:ecommerce/models/responseHandler/review_response.dart';
import '../models/responseHandler/product_response.dart';
import '../models/responseHandler/generic_response.dart';
import '../models/responseHandler/login_response.dart';
import '../models/responseHandler/similar_product_response.dart';

final type2JsonMap = {
  GenericResponse: (json) => GenericResponse.fromJson(json),
  LoginResponse: (json) => LoginResponse.fromJson(json),
  ProductResponse: (json) => ProductResponse.fromJson(json),
  ReviewResponse: (json) => ReviewResponse.fromJson(json),
  BrandResponse: (json) => BrandResponse.fromJson(json),
  SimilarProductResponse: (json) => SimilarProductResponse.fromJson(json),
};
