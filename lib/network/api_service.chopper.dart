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
    final Uri $url = Uri.parse('/api/v1/admin/auth/login');
    final $body = data;
    final Request $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<LoginResponse, LoginResponse>($request);
  }

  @override
  Future<Response<ProductResponse>> getProduct(int page, String q, int limit) {
    final Uri $url = Uri.parse('/api/v1/store/product-search');
    final Map<String, dynamic> $params = <String, dynamic>{
      'page': page,
      'q': q,
      'limit': limit,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<ProductResponse, ProductResponse>($request);
  }

  @override
  Future<Response<ReviewResponse>> getProductReview(String id, int limit) {
    final Uri $url = Uri.parse('/api/v1/store/product-review/product/${id}');
    final Map<String, dynamic> $params = <String, dynamic>{'limit': limit};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<ReviewResponse, ReviewResponse>($request);
  }

  @override
  Future<Response<SimilarProductResponse>> getSimilarProduct(
    String id,
    int limit,
  ) {
    final Uri $url = Uri.parse('/api/v1/store/product/${id}/similar');
    final Map<String, dynamic> $params = <String, dynamic>{'limit': limit};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<SimilarProductResponse, SimilarProductResponse>(
      $request,
    );
  }

  @override
  Future<Response<BrandResponse>> getBrand(String brand) {
    final Uri $url = Uri.parse('/api/v1/store/product/${brand}/brand');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<BrandResponse, BrandResponse>($request);
  }
}
