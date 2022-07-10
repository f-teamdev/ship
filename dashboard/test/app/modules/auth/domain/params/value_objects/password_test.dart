import 'package:flutter_test/flutter_test.dart';
import 'package:ship_dashboard/app/modules/auth/domain/params/value_objects/password.dart';

void main() {
  test('email validator', () {
    expect(Password('123456').validate().isRight(), true);
    expect(Password('').validate().isLeft(), true);
  });
}
