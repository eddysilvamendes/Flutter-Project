import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:merceariaonline/src/config/constom_colors.dart';
import 'package:merceariaonline/src/controller/auth_controller.dart';
import 'package:merceariaonline/src/screen/common_widgets/custon_text_field.dart';
import 'package:merceariaonline/src/services/validators.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

  /*final phoneFormater = MaskTextInputFormatter(
    mask: '### ## ##',
    filter: {'#': RegExp(r'[0-9]')},
  );*/
  final phoneFormater = MaskTextInputFormatter(
    mask: '## # ####-####',
    filter: {'#': RegExp(r'[0-9]')},
  );

  final cfpFormatter = MaskTextInputFormatter(
    mask: "###.###.###-##",
    filter: {'#': RegExp(r'[0-9]')},
  );

  final _formKey = GlobalKey<FormState>();
  final authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: CustomColors.customSwatchColor,
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Stack(
            children: [
              Positioned(
                left: 10,
                top: 10,
                child: SafeArea(
                  child: IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  //Titulo
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        //Nome do app
                        Text.rich(
                          TextSpan(
                            style: TextStyle(fontSize: 40),
                            children: [
                              TextSpan(
                                text: 'Registro',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
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
                            icon: Icons.email,
                            label: 'Email',
                            textInputType: TextInputType.emailAddress,
                            validator: emailValidator,
                            onSave: (value) {
                              authController.user.email = value;
                            },
                          ),
                          //Password
                          CustomTextField(
                            icon: Icons.lock,
                            label: 'Password',
                            isSecret: true,
                            validator: passwordValidator,
                            onSave: (value) {
                              authController.user.password = value;
                            },
                          ),
                          //Nome
                          CustomTextField(
                            icon: Icons.person,
                            label: 'Nome',
                            validator: nameValidator,
                            onSave: (value) {
                              authController.user.nome = value;
                            },
                          ),
                          //Telefone
                          CustomTextField(
                            icon: Icons.phone,
                            label: 'Telefone',
                            inputFormatters: [phoneFormater],
                            textInputType: TextInputType.phone,
                            validator: phoneValidator,
                            onSave: (value) {
                              authController.user.phone = value;
                            },
                          ),
                          //Butao de entrar
                          SizedBox(
                            height: 50,
                            child: Obx(
                              () => ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                ),
                                onPressed: authController.isLoading.value
                                    ? null
                                    : () {
                                        FocusScope.of(context).unfocus();
                                        if (_formKey.currentState!.validate()) {
                                          _formKey.currentState!.save();
                                          authController.signUp();
                                        }
                                      },
                                child: authController.isLoading.value
                                    ? const CircularProgressIndicator()
                                    : const Text(
                                        "Registrar Utilizador",
                                        style: TextStyle(fontSize: 18),
                                      ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
