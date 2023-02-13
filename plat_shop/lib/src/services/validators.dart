import 'package:get/get.dart';

String? emailValidator(String? email) {
  if (email == null || email.isEmpty) {
    return "Insira o seu email";
  }
  if (!email.isEmail) return "Insira um email valido";
  return null;
}

String? passwordValidator(String? password) {
  if (password == null || password.isEmpty) {
    return "Insira a sua palavra passe";
  }
  if (password.length < 6) {
    return "Insira uma palavra pass com pelo menos 6 caracteres";
  }
  return null;
}

String? nameValidator(String? name) {
  if (name == null || name.isEmpty) {
    return "Insira o nome!";
  }
  final names = name.split(' ');
  if (names.length == 1) return 'Insira o seu nome completo';
  return null;
}

String? phoneValidator(String? phone) {
  if (phone == null || phone.isEmpty) {
    return "Insira a sua palavra passe";
  }
  if (phone.length < 7 || !phone.isPhoneNumber) {
    return 'Insira um numero valido';
  }

  return null;
}
