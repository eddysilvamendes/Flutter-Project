// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  @JsonKey(name: 'fullname')
  String? nome;
  String? email;
  String? phone;
  //String? morada;
  String? cpf;
  String? password;
  String? id;
  String? token;

  UserModel({
    this.email,
    //this.morada,
    this.cpf,
    this.nome,
    this.password,
    this.phone,
    this.id,
    this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  @override
  String toString() {
    return 'UserModel(nome: $nome, email: $email, phone: $phone, cpf: $cpf, password: $password, id: $id, token: $token)';
  }
}
