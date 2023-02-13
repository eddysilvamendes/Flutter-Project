import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merceariaonline/src/controller/auth_controller.dart';
import 'package:merceariaonline/src/screen/common_widgets/custon_text_field.dart';
import 'package:merceariaonline/src/services/validators.dart';

class ForgotPasswordDialog extends StatelessWidget {
  ForgotPasswordDialog({
    Key? key,
    required String email,
  }) : super(key: key) {
    emailController.text = email;
  }
  final emailController = TextEditingController();
  final _formFieldKey = GlobalKey<FormFieldState>();
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          //Conteudo
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                //Titulo
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'Recuperação de senha',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                //Discriçaõ
                const Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Text(
                    'Digite seu email para recuperar sua senha',
                    textAlign: TextAlign.center,
                  ),
                ),
                //Campo de email
                CustomTextField(
                  formKey: _formFieldKey,
                  icon: Icons.email,
                  label: "Email",
                  validator: emailValidator,
                  controller: emailController,
                ),
                //Boatao de recuperacao
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      side: const BorderSide(
                        width: 2,
                        color: Colors.blue,
                      )),
                  onPressed: () {
                    if (_formFieldKey.currentState!.validate()) {
                      authController.resetPassword(emailController.text);
                      Get.back(result: true);
                    }
                  },
                  child: const Text(
                    'Recuperar',
                    style: TextStyle(
                      fontSize: 13,
                    ),
                  ),
                )
              ],
            ),
          ),
          //Botao para fechar
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.close),
            ),
          ),
        ],
      ),
    );
  }
}
