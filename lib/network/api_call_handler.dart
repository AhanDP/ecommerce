import 'package:chopper/chopper.dart';
import 'interceptors/custom_interceptor.dart';

/// Utility class for handling API calls with automatic success/failure handling
class ApiCallHandler {
  /// Executes an API call and handles loading, success, and failure states
  ///
  /// [apiCall] - The API function to execute
  /// [onLoading] - Callback when API call starts (show loader)
  /// [onSuccess] - Callback when API call succeeds with data
  /// [onFailure] - Callback when API call fails with error message and network status
  /// [onComplete] - Optional callback that runs after success or failure

  static Future<void> call<T>({
    required Future<Response<T>> Function() apiCall,
    required void Function() onLoading,
    required void Function(T? data) onSuccess,
    required void Function(String error, bool isNetworkError) onFailure,
    void Function()? onComplete,
  }) async {
    try {
      // Call onLoading
      onLoading();

      // Execute API call
      final response = await apiCall();

      // Check if response is successful
      bool isSuccess = response.statusCode == 200 || response.statusCode == 201;

      if (isSuccess) {
        // Call onSuccess with data
        onSuccess(response.body);
      } else {
        // Call onFailure with error message (not a network error)
        onFailure(response.error?.toString() ?? 'Unknown error occurred', false);
      }
    } on NetworkException catch (e) {
      // Handle network exception - pass true for isNetworkError
      onFailure(e.error, true);
    } catch (e) {
      // Handle any other exception - not a network error
      onFailure(e.toString(), false);
    } finally {
      // Call onComplete if provided
      onComplete?.call();
    }
  }
}
