import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deduasql/models/deudas_model.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> getDeudas() async {
  try {
    List deudas = [];

    CollectionReference deudaRef = db.collection("deudas");
    QuerySnapshot queryDeudas = await deudaRef.get();

    queryDeudas.docs.forEach((element) {
      print(element.data());
      //final dataFinal = {...mapId, ...element.data()};
      deudas.add(element.data());
    });

    return deudas;
  } catch (error) {
    print(error);
  }
  return [];
}

Future<List<DeudaModel>> getDeudasAll() async {
  try {
    final snapshot = await db.collection("deudas").get();
    final deudaData = snapshot.docs.map((e) => DeudaModel.fromSnapshot(e)).toList();
    print(deudaData);
    return deudaData;
  }catch(error) {
    print(error);
    return [];
  }
}

Future<List<DeudaModel>> getDeudasUser(String id_user) async {
  try {
    final snapshot = await db.collection("deudas").where("uid",isEqualTo: id_user).get();
    final deudaData = snapshot.docs.map((e) => DeudaModel.fromSnapshot(e)).toList();
    print(deudaData);
    return deudaData;
  }catch(error) {
    print(error);
    return [];
  }
}

void pagar(id_deuda, n_cuota) {
  try {
    final deudaRef = db.collection("deudas").doc(id_deuda);
    deudaRef.update({
      "n_cuota": n_cuota - 1,
    });
  } catch(error) {
    print("Error "+error.toString());
  }
}

void eliminar(id_deuda) {
  try {
    final deudaRef = db.collection("deudas").doc(id_deuda);
    deudaRef.delete();
  } catch(error) {
    print("Error "+error.toString());
  }
}