import 'package:merceariaonline/src/constants/endpoints.dart';
import 'package:merceariaonline/src/models/user_model.dart';
import 'package:merceariaonline/src/repository/auth_errors.dart' as auth_error;
import 'package:merceariaonline/src/result/auth_result.dart';
import 'package:merceariaonline/src/services/http_manager.dart';

UserModel user = UserModel();

class AuthRepository {
  final HttpManager _httpManager = HttpManager();

  AuthResult handleUserOrError(Map<dynamic, dynamic> result) {
    if (result['result'] != null) {
      final user = UserModel.fromJson(result['result']);
      return AuthResult.success(user);
    } else {
      return AuthResult.error(
        auth_error.authErrorsString(
          result['error'],
        ),
      );
    }
  }

  Future<AuthResult> signIn(
      {required String email, required String password}) async {
    final result = await _httpManager.restRequest(
      url: EndPoint.signin,
      method: HttpMethod.post,
      body: {
        "email": email,
        "password": password,
      },
    );
    print(result.toString());
    return handleUserOrError(result);
  }

  Future<AuthResult> validateToken(String token) async {
    final result = await _httpManager.restRequest(
      url: EndPoint.validateToken,
      method: HttpMethod.post,
      headers: {'X-Parse-Session-Token': token},
    );

    return handleUserOrError(result);
  }

  Future<AuthResult> signUp(UserModel userModel) async {
    final result = await _httpManager.restRequest(
        url: EndPoint.signup, method: HttpMethod.post, body: user.toJson());
    return handleUserOrError(result);
  }

  Future<void> resetPassword(String email) async {
    await _httpManager.restRequest(
        url: EndPoint.resetPassword,
        method: HttpMethod.post,
        body: {'email': email});
  }

  Future<bool> changePassword({
    required String email,
    required String currentPassword,
    required String newPassword,
    required String token,
  }) async {
    final result = await _httpManager.restRequest(
      url: EndPoint.changePassword,
      method: HttpMethod.post,
      body: {
        'email': email,
        'currentPassword': currentPassword,
        'newPassword': newPassword
      },
      headers: {'X-Parse-Session-Token': token},
    );
    return result['error'] == null;
  }
}
