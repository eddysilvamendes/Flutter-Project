import 'package:get/get.dart';
import 'package:merceariaonline/src/constants/storage_keys.dart';
import 'package:merceariaonline/src/models/user_model.dart';
import 'package:merceariaonline/src/repository/auth_repository.dart';
import 'package:merceariaonline/src/result/auth_result.dart';
import 'package:merceariaonline/src/routes/app_routes.dart';
import 'package:merceariaonline/src/services/utils_services.dart';

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
    Get.offAllNamed(PagesRoutes.baseRoutes);
    utilsServices.showToast(message: "Welcome");
  }

  Future<void> validateToken() async {
    //recuperar Token Localmente
    String? token = await utilsServices.getLocalData(key: StorageKeys.token);

    if (token == null) {
      Get.offAllNamed(PagesRoutes.signInRoute);
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
    Get.offAllNamed(PagesRoutes.signInRoute);
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
