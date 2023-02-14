String authErrorsString(String? code) {
  switch (code) {
    case 'INVALID_CREDENTIALS':
      return 'Email e/ou palavra passe invalidos';

    case 'Invalid session tolen':
      return 'Token Invalido';

    case 'INVALID_FULLNAME':
      return 'Ocorreu um erro ao cadastrar: Nome Invalido';

    case 'INVALID_CPF':
      return 'Ocorreu um erro ao cadastrar: CPF Invalido';

    case 'INVALID_PHONE':
      return 'Ocorreu um erro ao cadastrar: Telefone Invalido';

    default:
      return "Um erro indefinido occoreu";
  }
}
