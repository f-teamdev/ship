import 'package:admin/app/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'auth_controller.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool _isObscuredText = true;

  @override
  Widget build(BuildContext context) {
    final controller = Modular.get<AuthController>();
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: 400,
            maxWidth: 450,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 17),
            child: Card(
              elevation: 12,
              child: Padding(
                padding: const EdgeInsets.all(17.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 200,
                      child: Image.asset("assets/images/logo.png"),
                    ),
                    SizedBox(height: 55),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: controller.cpfValidator,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        CpfFormatter(),
                      ],
                      decoration: InputDecoration(
                        hintText: "CPF",
                        fillColor: secondaryColor,
                        filled: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                    TextField(
                      obscureText: _isObscuredText,
                      decoration: InputDecoration(
                        hintText: "SENHA",
                        fillColor: secondaryColor,
                        filled: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _isObscuredText = !_isObscuredText;
                            });
                          },
                          icon: Icon(_isObscuredText ? Icons.visibility_off : Icons.visibility),
                        ),
                      ),
                    ),
                    SizedBox(height: 50),
                    ElevatedButton(
                      style: ButtonStyle(),
                      onPressed: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('ENTRAR'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CpfFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.length > 14) {
      return oldValue;
    }
    var text = newValue.text.replaceAll(new RegExp(r'[^\d\s]+'), '');

    final buffer = StringBuffer();

    for (var i = 0; i < text.length; i++) {
      if (i == 3) {
        buffer.writeAll(['.', text[i]]);
      } else if (i == 6) {
        buffer.writeAll(['.', text[i]]);
      } else if (i == 9) {
        buffer.writeAll(['-', text[i]]);
      } else {
        buffer.write(text[i]);
      }
    }

    text = buffer.toString();

    return newValue.copyWith(text: text, selection: TextSelection.collapsed(offset: text.length));
  }
}
