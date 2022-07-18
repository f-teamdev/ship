import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:fpdart/fpdart.dart' hide State;

import '../../shared/constants.dart';
import 'domain/exceptions/exceptions.dart';
import 'domain/params/login_credentials.dart';
import 'presentation/states/auth_state.dart';
import 'presentation/stores/auth_store.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool _isObscuredText = true;
  final credentials = LoginCredentials();

  final store = Modular.get<AuthStore>();

  late final Disposer _observerDispose;

  @override
  void initState() {
    super.initState();

    _observerDispose = store.observer(onError: (error) {
      _showError(error.message);
    });
  }

  _showError(String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  void dispose() {
    _observerDispose();
    super.dispose();
  }

  _login() {
    credentials.validate().fold((error) {
      _showError(error.message);
    }, store.login);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
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
                    SizedBox(
                      width: 50,
                      child: Image.asset("assets/images/logo.jpg"),
                    ),
                    const SizedBox(height: 55),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onChanged: credentials.setEmail,
                      validator: (text) => credentials.email.validate().fold(id, (r) => null),
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: "Email",
                        fillColor: secondaryColor,
                        filled: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      obscureText: _isObscuredText,
                      onChanged: credentials.setPassword,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (text) => credentials.password.validate().fold(id, (r) => null),
                      decoration: InputDecoration(
                        hintText: "Senha",
                        fillColor: secondaryColor,
                        filled: true,
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
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
                    const SizedBox(height: 50),
                    TripleBuilder<AuthStore, AuthException, AuthState>(
                      builder: (context, triple) {
                        return ElevatedButton(
                          style: const ButtonStyle(),
                          onPressed: triple.isLoading ? null : _login,
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('ENTRAR'),
                          ),
                        );
                      },
                    )
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
