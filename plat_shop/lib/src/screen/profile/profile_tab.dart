import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merceariaonline/src/controller/auth_controller.dart';
import 'package:merceariaonline/src/screen/common_widgets/custon_text_field.dart';
import 'package:merceariaonline/src/services/validators.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  final authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const Text('Perfil do utilizador'),
        actions: [
          IconButton(
            onPressed: () => authController.signOut(),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
        children: [
          //Email
          CustomTextField(
            icon: Icons.email,
            label: 'Email',
            initialValue: authController.user.email,
            isReadOnly: true,
          ),
          //Nome
          CustomTextField(
            icon: Icons.person,
            label: 'Nome',
            initialValue: authController.user.nome,
            isReadOnly: true,
          ),
          // Telefone
          CustomTextField(
            icon: Icons.phone,
            label: 'Telefone',
            initialValue: authController.user.phone,
            isReadOnly: true,
          ),
          CustomTextField(
            isReadOnly: true,
            icon: Icons.file_copy,
            label: 'Cpf',
            initialValue: authController.user.cpf,
            isSecret: true,
          ),
          //Morada
          /* CustomTextField(
            icon: Icons.home,
            label: 'Morada',
            initialValue: appData.user.morada,
            isReadOnly: true,
          ),*/

          //Buttao de actualizar
          SizedBox(
            height: 50,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                side: const BorderSide(color: Colors.green),
              ),
              onPressed: () {
                updatePassword();
              },
              child: const Text('Actualizar Senha'),
            ),
          )
        ],
      ),
    );
  }

  Future<bool?> updatePassword() {
    final newpasswordController = TextEditingController();
    final currentpasswordController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Stack(
              children: [
                //Content
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Text(
                            'Acualização de senha',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        CustomTextField(
                          icon: Icons.lock,
                          label: "Senha actual",
                          validator: passwordValidator,
                          isSecret: true,
                          controller: currentpasswordController,
                        ),
                        CustomTextField(
                          controller: newpasswordController,
                          icon: Icons.lock_outline,
                          label: "Nova senha",
                          isSecret: true,
                          validator: passwordValidator,
                        ),
                        CustomTextField(
                          icon: Icons.lock_outline,
                          label: "Confirmar senha",
                          isSecret: true,
                          validator: (password) {
                            final result = passwordValidator(password);
                            if (result != null) {
                              return result;
                            }
                            if (password != newpasswordController.text) {
                              return 'Password não sao equivalentes';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 45,
                          child: Obx(
                            () => ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              onPressed: authController.isLoading.value
                                  ? null
                                  : () {
                                      if (formKey.currentState!.validate()) {
                                        authController.changePassword(
                                          newPassword:
                                              newpasswordController.text,
                                          currentPassword:
                                              currentpasswordController.text,
                                        );
                                      }
                                    },
                              child: authController.isLoading.value
                                  ? const CircularProgressIndicator()
                                  : const Text('Actualizar'),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                //Close button
                Positioned(
                  top: 5,
                  right: 5,
                  child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.close)),
                )
              ],
            ),
          );
        });
  }
}
