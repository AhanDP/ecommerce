import 'package:ecommerce/models/api/login_response.dart';

import '../models/api/generic_response.dart';

final type2JsonMap = {
  GenericResponse: (json) => GenericResponse.fromJson(json),
  LoginResponse: (json) => LoginResponse.fromJson(json),
};
