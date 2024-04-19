abstract class BaseAPIServices {
  Future<dynamic> getApiResponse({required String url});
  Future<dynamic> postApiResponse({required String url,required dynamic data});
}