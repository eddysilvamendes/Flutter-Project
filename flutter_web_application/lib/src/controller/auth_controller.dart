import 'package:flutter_web_application/src/constants/storage_keys.dart';
import 'package:flutter_web_application/src/models/user_model.dart';
import 'package:flutter_web_application/src/repository/auth_repository.dart';
import 'package:flutter_web_application/src/result/auth_result.dart';
import 'package:flutter_web_application/src/routing/pages.dart';
import 'package:flutter_web_application/src/services/utils_services.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  UtilsServices utilsServices = UtilsServices();
  RxBool isLoading = false.obs;
  final AuthRepository authRepository = AuthRepository();
  UserModel user = UserModel();

  @override
  void onInit() {
    super.onInit();
    validateToken();
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    isLoading.value = true;
    AuthResult result =
        await authRepository.signIn(email: email, password: password);

    isLoading.value = false;

    result.when(
      success: (user) {
        this.user = user;
        saveTokenAndProceedToBase();
      },
      error: (message) {
        utilsServices.showToast(message: message, isError: true);
      },
    );
  }

  void saveTokenAndProceedToBase() {
    //Salvar Token
    utilsServices.saveLocalData(key: StorageKeys.token, data: user.token!);
    //Ir para base
    Get.offAllNamed(overViewPageRoute);
    utilsServices.showToast(message: "Welcome");
  }

  Future<void> validateToken() async {
    //recuperar Token Localmente
    String? token = await utilsServices.getLocalData(key: StorageKeys.token);

    if (token == null) {
      Get.offAllNamed(authenticationPageRoute);
      return;
    }

    AuthResult result = await authRepository.validateToken(token);
    result.when(
      success: (user) {
        this.user = user;
        saveTokenAndProceedToBase();
      },
      error: (error) {
        signOut();
      },
    );
  }

  Future<void> signOut() async {
    //Zerar o user
    user = UserModel();
    //Remover o token localemnte
    await utilsServices.removeLocalData(key: StorageKeys.token);
    //Ir para login
    Get.offAllNamed(authenticationPageRoute);
  }

  Future<void> signUp() async {
    isLoading.value = true;
    AuthResult result = await authRepository.signUp(user);
    isLoading.value = false;
    result.when(
      success: (user) {
        this.user = user;
        saveTokenAndProceedToBase();
      },
      error: (message) {
        utilsServices.showToast(message: message, isError: true);
      },
    );
  }

  Future<void> resetPassword(String email) async {
    await authRepository.resetPassword(email);
  }

  Future<void> changePassword({
    required String newPassword,
    required String currentPassword,
  }) async {
    isLoading.value = true;
    final result = await authRepository.changePassword(
      email: user.email!,
      currentPassword: currentPassword,
      newPassword: newPassword,
      token: user.token!,
    );
    isLoading.value = false;
    if (result) {
      //Mensagem
      utilsServices.showToast(message: 'Password actualizado com sucesso!');
      //Logout
      signOut();
    } else {
      utilsServices.showToast(
          message: 'Password actual incorrecto', isError: true);
    }
  }
}
