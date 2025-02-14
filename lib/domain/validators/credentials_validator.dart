import 'package:lucid_validation/lucid_validation.dart';
import 'package:rachadinha/domain/dtos/credentials.dart';

class CredentialsValidator extends LucidValidator<Credentials> {
  CredentialsValidator() {
    ruleFor((c) => c.email, key: 'email') //
        .notEmpty(message: 'Preenchimento obrigatório.')
        .validEmail(message: 'Email inválido.');

    ruleFor((c) => c.password, key: 'password') //
        .notEmpty(message: 'Preenchimento obrigatório.')
        .minLength(6, message: 'Mínimo 6 caracteres.')
        .mustHaveLowercase(message: 'Mínimo 1 letra minúscula.')
        .mustHaveUppercase(message: 'Mínimo 1 letra maiúscula.')
        .mustHaveNumber(message: 'Mínimo 1 número.')
        .mustHaveSpecialCharacter(message: 'Mínimo 1 caractere especial.');
  }
}
