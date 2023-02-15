import 'package:flutter/material.dart';
import 'package:flutter_web_application/src/controller/auth_controller.dart';
import 'package:flutter_web_application/src/constants/style.dart';
import 'package:flutter_web_application/src/services/utils_services.dart';
import 'package:flutter_web_application/src/services/validators.dart';
import 'package:flutter_web_application/src/widgets/custom_text.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthenticationScreen extends GetView<AuthController> {
  final _formKey = GlobalKey<FormState>();
  final UtilsServices utilsServices = UtilsServices();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  AuthenticationScreen({super.key});
  final snackbar = SnackBar(
    content: const Text('Campos Invalidos'),
    action: SnackBarAction(
      label: 'Undo',
      onPressed: () {
        // Some code to undo the change.
      },
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400),
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Image.asset("assets/icons/logo.png"),
                    ),
                    Expanded(child: Container()),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Text(
                      "Login",
                      style: GoogleFonts.roboto(
                          fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    CustomText(
                      text: "Welcome back to the admin panel.",
                      color: lightGrey,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: emailController,
                  validator: emailValidator,
                  decoration: InputDecoration(
                    labelText: "Email",
                    hintText: "abc@domain.com",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: passwordController,
                  validator: passwordValidator,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password",
                    hintText: "123",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(value: true, onChanged: (value) {}),
                        const CustomText(
                          text: "Remeber Me",
                        ),
                      ],
                    ),
                    CustomText(text: "Forgot password?", color: active)
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: controller.isLoading.value
                      ? null
                      : () {
                          FocusScope.of(context).unfocus();
                          if (_formKey.currentState!.validate()) {
                            controller.signIn(
                              email: emailController.text,
                              password: passwordController.text,
                            );
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackbar);
                          }
                        },
                  child: Container(
                    decoration: BoxDecoration(
                      color: active,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    alignment: Alignment.center,
                    width: double.maxFinite,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: const CustomText(
                      text: "Login",
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(text: "Do not have admin credentials? "),
                      TextSpan(
                        text: "Request Credentials! ",
                        style: TextStyle(
                          color: active,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
