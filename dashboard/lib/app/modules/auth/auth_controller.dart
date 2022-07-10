import 'package:characters/src/extensions.dart';

class AuthController {
  Future<void> login({required String cpf, required String password}) async {}

  String? cpfValidator(String? value) {
    if (value == null) {
      return null;
    }
    if (value.isEmpty) {
      return 'Preencha esse campo';
    }
    var cpf = value.replaceAll(new RegExp(r'[^\d\s]+'), '');

    if (cpf.length < 11) {
      return 'Preencha esse campo (${11 - cpf.length})';
    }

    //cpf validation
    var first = 0;
    var second = 0;
    var i = 10;
    for (var char in cpf.characters.getRange(0, 9)) {
      first += (int.parse(char) * i);
      second += (int.parse(char) * (i + 1));
      i--;
    }
    second += (int.parse(cpf[9]) * 2);

    first = (first * 10) % 11;
    first = first == 10 ? 0 : first;

    second = (second * 10) % 11;
    second = second == 10 ? 0 : second;

    if (!cpf.endsWith('$first$second')) {
      return 'cpf não é válido';
    }
    return null;
  }
}
