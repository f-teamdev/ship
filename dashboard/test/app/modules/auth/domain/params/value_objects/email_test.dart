import 'package:flutter_test/flutter_test.dart';
import 'package:ship_dashboard/app/modules/auth/domain/params/value_objects/email.dart';

void main() {
  test(' email validator', () {
    expect(Email('jacobaraujo7@gmail.com').validate().isRight(), true);
    expect(Email('jacobaraujo7gmail.com').validate().isLeft(), true);
    expect(Email('jacobaraujo7@gmail').validate().isLeft(), true);
    expect(Email('').validate().isLeft(), true);
  });
}
