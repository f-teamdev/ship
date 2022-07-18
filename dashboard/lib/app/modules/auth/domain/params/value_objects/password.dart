import 'package:fpdart/fpdart.dart';

class Password {
  final String _value;

  Password(this._value);

  Either<String, Object?> validate([Object? object]) {
    if (_value.isEmpty) {
      return const Left('Campo senha não pode ser vazio');
    }

    return Right(object);
  }

  @override
  String toString() => _value;
}
