// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

part of 'api_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$ApiService extends ApiService {
  _$ApiService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = ApiService;

  @override
  Future<Response<LoginResponse>> login(Map<String, dynamic> data) {
    final Uri $url = Uri.parse('/api/admin/auth/login');
    final $body = data;
    final Request $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<LoginResponse, LoginResponse>($request);
  }

  @override
  Future<Response<ProductResponse>> getProduct(Map<String, dynamic> data) {
    final Uri $url = Uri.parse('/api/v1/store/product-search');
    final Map<String, dynamic> $params = <String, dynamic>{'data': data};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<ProductResponse, ProductResponse>($request);
  }
}
