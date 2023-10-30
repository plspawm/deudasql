import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deduasql/custom/customShape.dart';
import 'package:deduasql/screens/deudas_dos.dart';
import 'package:deduasql/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
//Import firestore database
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class IngresoDeudas extends StatefulWidget {
  const IngresoDeudas({super.key});

  @override
  State<IngresoDeudas> createState() => _IngresoDeudasState();
}

class _IngresoDeudasState extends State<IngresoDeudas> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  DateTime selectedDate = DateTime.now();
  final nombreDeuda = TextEditingController();
  final nCuota = TextEditingController();
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  late String userId;

  //DatabaseReference ref = FirebaseDatabase.instance.ref("deudas");
  CollectionReference deudasRef =
      FirebaseFirestore.instance.collection("deudas");
  
  @override
  void initState() {
    super.initState();
    final User? user = _auth.currentUser;
    if(user != null) {
      userId = user.uid;
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const MyLogin(),
        ),
      );
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<bool?> toast(String message) {
    //Fluttertoast.cancel();
    return Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 4,
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
        fontSize: 15.0);
  }

  bool isNumeric(String? s) {
    // ignore: unnecessary_null_comparison
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        /* shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ), */
        toolbarHeight: 130,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        flexibleSpace: ClipPath(
          clipper: Customshape(),
          child: Container(
            height: 250,
            width: MediaQuery.of(context).size.width,
            color: Theme.of(context).colorScheme.inversePrimary,//Colors.red,
            child: const Center(child: Text("DEUDAS QL",style: TextStyle(fontSize: 20,color: Colors.white),)),
          ),
        ),
        //backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        /* title: Text(
          "DEUDAS QL",
          style: Theme.of(context).textTheme.labelMedium,
        ), */
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          iconSize: 20.0,
          color: Colors.white,
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => const MyDeudas2(),
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
              Text("Bienvenido",
                  style: Theme.of(context).textTheme.displayLarge),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un nombre para su deuda!';
                  }
                  return null;
                },
                controller: nombreDeuda,
                decoration: const InputDecoration(
                  hintText: 'Nombre de Deuda',
                ),
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                validator: (value) {
                  if (!isNumeric(value)) {
                    return "Debe ingresar un número!";
                  }
                  return null;
                },
                controller: nCuota,
                decoration: const InputDecoration(
                  hintText: 'N° Cuotas',
                ),
              ),
              const SizedBox(height: 8.0),
              ElevatedButton(
                onPressed: () => _selectDate(context),
                child: const Text("Fecha Primer Pago"),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Text("${selectedDate.toLocal()}".split(' ')[0]),
              const SizedBox(
                height: 24.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          _isLoading = true;
                        });
                        await deudasRef.add({
                          "nombre_deuda": nombreDeuda.text,
                          "n_cuota": int.parse(nCuota.text),
                          "fecha_pago": selectedDate.toLocal(),
                          "fecha_proximo_pago": selectedDate.add(const Duration(days: 30)).toLocal(),
                          "uid": userId
                        });
                        setState(() {
                          _isLoading = false;
                        });
                        /* ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Sending Message"),
                      )); */
                        toast("Deuda Ingresada!!");
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow,
                    ),
                    child: !_isLoading
                        ? const Text("Ingresar")
                        : const CircularProgressIndicator(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
