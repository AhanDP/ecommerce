import '../models/responseHandler/product_response.dart';
import '../models/responseHandler/generic_response.dart';
import '../models/responseHandler/login_response.dart';

final type2JsonMap = {
  GenericResponse: (json) => GenericResponse.fromJson(json),
  LoginResponse: (json) => LoginResponse.fromJson(json),
  ProductResponse: (json) => ProductResponse.fromJson(json),
};
