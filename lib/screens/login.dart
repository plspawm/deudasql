import 'package:deduasql/exceptions/auth_exception.dart';
import 'package:deduasql/screens/deudas_dos.dart';
import 'package:deduasql/screens/registro.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({super.key});

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _user = TextEditingController();
  final _contrasena = TextEditingController();
  bool success = false;
  String? userEmail = "";

  void _signInWithEmailAndPassword() async {
    try {
      final User? user = (await _auth.signInWithEmailAndPassword(
        email: _user.text,
        password: _contrasena.text,
      ))
          .user;

      if (user != null) {
        setState(() {
          success = true;
          userEmail = user.email;
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const MyDeudas2(),
            ),
          );
        });
      } else {
        setState(() {
          success = false;
        });
      }
    } on FirebaseAuthException catch (error) {
      final ex = AuthException.code(error.code);
      // ignore: use_build_context_synchronously
      showModal(context, ex.mensaje);
    }
  }

  void showModal(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: Text(message),
        actions: <TextButton>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Close'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(80),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text('Bienvenido', style: Theme.of(context).textTheme.displayLarge,)),
              /* Text("Bienvenido",
                  style: Theme.of(context).textTheme.displayLarge), */
              TextFormField(
                controller: _user,
                decoration: const InputDecoration(
                  hintText: 'Usuario',
                ),
              ),
              TextFormField(
                controller: _contrasena,
                decoration: const InputDecoration(
                  hintText: 'Contraseña',
                ),
                obscureText: true,
              ),
              const SizedBox(
                height: 24,
              ),
              ElevatedButton(
                onPressed: () {
                  _signInWithEmailAndPassword();
                  /* if (_user.text == "plspawn" && _contrasena.text == "123456") {
                    print("Ingresando ...");
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => MyDeudas2(),
                      ),
                    );
                  } */
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow,
                ),
                child: const Text('INGRESAR'),
              ),
              const SizedBox(height: 10.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const Registro(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow,
                ),
                child: const Text('REGISTRARSE'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
