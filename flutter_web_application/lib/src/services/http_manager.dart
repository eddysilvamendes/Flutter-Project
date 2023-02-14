import 'package:dio/dio.dart';

abstract class HttpMethod {
  static const String post = 'POST';
  static const String get = 'GET';
  static const String put = 'PUT';
  static const String delete = 'DELETE';
  static const String patch = 'PATCH';
}

class HttpManager {
  Future<Map> restRequest({
    required String url,
    required String method,
    Map? headers,
    Map? body,
  }) async {
    //Headers da requisicao

    final defaultHeaders = headers?.cast<String, String>() ?? {}
      ..addAll(({
        'content-type': 'application/json',
        'accept': 'application/json',
        'X-Parse-Application-Id': '3aYiFEpcodmJitJjCNrkOL56kHAIvXhoYEin2tLA',
        'X-Parse-REST-API-Key': 'iivTIds3j7XQ4v2UE9X2GgTA7IDRJAN7zMokZdoL',
      }));
    Dio dio = Dio();
    // Request para backend
    try {
      Response response = await dio.request(
        url,
        options: Options(
          method: method,
          headers: defaultHeaders,
        ),
        data: body,
      );

      //Retorno de resultado do backend
      return response.data;
    } on DioError catch (e) {
      //Retorno do erro do DIO
      return e.response?.data ?? {};
    } catch (e) {
      //Retorno de outro tipo de erro
      return {};
    }
  }
}
