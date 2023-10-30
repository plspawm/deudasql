import 'package:deduasql/custom/customShape.dart';
import 'package:deduasql/screens/deudas_dos.dart';
import 'package:deduasql/screens/login.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Registro extends StatefulWidget {
  const Registro({super.key});

  @override
  State<Registro> createState() => _RegistroState();
}

class _RegistroState extends State<Registro>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final email = TextEditingController();
  final password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _success = false;
  String _userEmail = "";

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _register() async {
    final User? user = (await _auth.createUserWithEmailAndPassword(
      email: email.text,
      password: password.text,
    ))
        .user;
    if (user != null) {
      setState(() {
        _success = true;
        _userEmail = user.email!;
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const MyDeudas2(),
        ));
      });
    } else {
      setState(() {
        _success = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 130,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        flexibleSpace: ClipPath(
          clipper: Customshape(),
          child: Container(
            height: 250,
            width: MediaQuery.of(context).size.width,
            color: Theme.of(context).colorScheme.inversePrimary, //Colors.red,
            child: const Center(
                child: Text(
              "DEUDAS QL",
              style: TextStyle(fontSize: 20, color: Colors.white),
            )),
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          iconSize: 20.0,
          color: Colors.white,
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => const MyLogin(),
            ));
          },
        ),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/fondo.png"),
              fit: BoxFit.cover,
            ),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Registro", style: Theme.of(context).textTheme.displayLarge),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty || !EmailValidator.validate(value)) {
                    return 'Por favor ingrese un Email valido!';
                  }
                  return null;
                },
                controller: email,
                decoration: const InputDecoration(
                  hintText: 'Correo',
                ),
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Debe ingresar una contraseña";
                  }
                  return null;
                },
                controller: password,
                decoration: const InputDecoration(
                  hintText: 'Contraseña',
                ),
                obscureText: true,
              ),
              const SizedBox(height: 24.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          _isLoading = true;
                        });
                        _register();
                        setState(() {
                          _isLoading = false;
                        });
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Resgistro Exitoso"),
                        ));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow,
                    ),
                    child: !_isLoading
                        ? const Text("Registrar")
                        : const CircularProgressIndicator(),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(_success == false
                        ? ''
                        : (_success
                            ? 'Successfully registered $_userEmail'
                            : 'Registration failed')),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
