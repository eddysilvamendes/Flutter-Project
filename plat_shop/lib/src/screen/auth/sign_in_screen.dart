import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merceariaonline/src/config/constom_colors.dart';
import 'package:merceariaonline/src/controller/auth_controller.dart';
import 'package:merceariaonline/src/routes/app_routes.dart';
import 'package:merceariaonline/src/screen/auth/components/forgot_password_dialog.dart';
import 'package:merceariaonline/src/screen/common_widgets/custon_text_field.dart';
import 'package:merceariaonline/src/screen/home/components/app_name.dart';
import 'package:merceariaonline/src/services/utils_services.dart';
import 'package:merceariaonline/src/services/validators.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final UtilsServices utilsServices = UtilsServices();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: CustomColors.customSwatchColor,
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            children: [
              //Titulo
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //Nome do app
                    const AppName(
                      color: Colors.white,
                      size: 40,
                    ),
                    //Categoria
                    SizedBox(
                      height: 30,
                      child: DefaultTextStyle(
                        style: const TextStyle(fontSize: 25),
                        child: AnimatedTextKit(
                          pause: Duration.zero,
                          repeatForever: true,
                          animatedTexts: [
                            FadeAnimatedText("Frutas"),
                            FadeAnimatedText("Verduras"),
                            FadeAnimatedText("Carnes"),
                            FadeAnimatedText("Cereais"),
                            FadeAnimatedText("Laticineos"),
                            FadeAnimatedText("Bebidas"),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //Formulario
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 40,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30),
                  ),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      //Email
                      CustomTextField(
                        controller: emailController,
                        icon: Icons.email,
                        label: 'Email',
                        validator: emailValidator,
                      ),
                      //Password
                      CustomTextField(
                        controller: passwordController,
                        icon: Icons.lock,
                        label: 'Password',
                        isSecret: true,
                        validator: passwordValidator,
                      ),
                      //Butao de entrar
                      GetX<AuthController>(
                        builder: (authController) {
                          return SizedBox(
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  primary: CustomColors.buttomColor),
                              onPressed: authController.isLoading.value
                                  ? null
                                  : () {
                                      FocusScope.of(context).unfocus();
                                      if (_formKey.currentState!.validate()) {
                                        authController.signIn(
                                          email: emailController.text,
                                          password: passwordController.text,
                                        );
                                      } else {
                                        utilsServices.showToast(
                                            message: "Campos Invalidos",
                                            isError: true);
                                      }
                                    },
                              child: authController.isLoading.value
                                  ? const CircularProgressIndicator()
                                  : const Text(
                                      "Entrar",
                                      style: TextStyle(fontSize: 18),
                                    ),
                            ),
                          );
                        },
                      ),
                      //Esqueceu a senha
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () async {
                            final bool? result = await showDialog(
                              context: context,
                              builder: (_) => ForgotPasswordDialog(
                                  email: emailController.text),
                            );
                            if (result ?? false) {
                              utilsServices.showToast(
                                message:
                                    "Link de recuperação enviado para o email",
                              );
                            }
                          },
                          child: Text(
                            "Esqueceu a Senha?",
                            style: TextStyle(
                                color: CustomColors.customContrastColor),
                          ),
                        ),
                      ),
                      //Divider
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: Colors.grey.withAlpha(90),
                                thickness: 2,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Text("Ou"),
                            ),
                            Expanded(
                              child: Divider(
                                color: Colors.grey.withAlpha(90),
                                thickness: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      //Botao de registro
                      SizedBox(
                        height: 50,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                              width: 2,
                              color: CustomColors.buttomColor,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                          onPressed: () => Get.toNamed(
                            PagesRoutes.signUpRoute,
                          ),
                          child: const Text(
                            "Criar Conta",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
