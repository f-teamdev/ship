import 'package:flutter_test/flutter_test.dart';
import 'package:ship_dashboard/app/modules/auth/domain/params/login_credentials.dart';

void main() {
  test('Validate LoginCredencials', () {
    final credentials = LoginCredentials();
    expect(credentials.validate().isLeft(), true);

    credentials.setEmail('jacobaraujo7@gmail.com');
    expect(credentials.validate().isLeft(), true);

    credentials.setPassword('12345678');
    expect(credentials.validate().isRight(), true);
  });
}
