import 'dart:async';
import 'package:chopper/chopper.dart';
import '../models/responseHandler/generic_response.dart';

typedef JsonFactory<T> = T Function(Map<String, dynamic> json);

class JsonSerializableConverter extends JsonConverter {
  final Map<Type, JsonFactory> factories;

  const JsonSerializableConverter(this.factories);

  T? _decodeMap<T>(Map<String, dynamic> values) {
    final jsonFactory = factories[T];
    if (jsonFactory == null || jsonFactory is! JsonFactory<T>) {
      return null;
    }
    return jsonFactory(values);
  }

  List<T> _decodeList<T>(Iterable values) =>
      values.where((v) => v != null).map<T>((v) => _decode<T>(v)).toList();

  dynamic _decode<T>(entity) {
    if (entity is Iterable) return _decodeList<T>(entity as List);
    if (entity is Map) return _decodeMap<T>(Map<String, dynamic>.from(entity));
    return entity;
  }

  @override
  FutureOr<Response<ResultType>> convertResponse<ResultType, Item>(
      Response response,
      ) async {
    final jsonRes = await super.convertResponse(response);
    final body = _decode<Item>(jsonRes.body);
    return jsonRes.copyWith<ResultType>(body: body);
  }

  @override
  FutureOr<Response> convertError<ResultType, Item>(Response response) async {
    final jsonRes = await super.convertError(response);

    try {
      // Try decoding structured error
      GenericResponse gResponse = GenericResponse.fromJson(
        Map<String, dynamic>.from(jsonRes.body),
      );
      return jsonRes.copyWith(body: gResponse);
    } catch (_) {
      // Fallback to plain string message
      return jsonRes.copyWith(body: jsonRes.body.toString());
    }
  }
}