import 'package:fpdart/fpdart.dart';
import 'package:string_validator/string_validator.dart' as validator;

class Email {
  final String _value;

  Email(this._value);

  Either<String, Object?> validate([Object? object]) {
    if (_value.isEmpty) {
      return const Left('Campo email não pode ser vazio');
    }

    if (!validator.isEmail(_value)) {
      return const Left('Isso não é um email');
    }
    return Right(object);
  }

  @override
  String toString() => _value;
}
