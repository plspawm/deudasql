import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deduasql/models/deudas_model.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> getDeudas() async {
  try {
    List deudas = [];

    CollectionReference deudaRef = db.collection("deudas");
    QuerySnapshot queryDeudas = await deudaRef.get();

    for (var element in queryDeudas.docs) {
      //final dataFinal = {...mapId, ...element.data()};
      deudas.add(element.data());
    }

    return deudas;
  } catch (error) {
    throw Exception(error);
  }
}

Future<List<DeudaModel>> getDeudasAll() async {
  try {
    final snapshot = await db.collection("deudas").get();
    final deudaData = snapshot.docs.map((e) => DeudaModel.fromSnapshot(e)).toList();
    return deudaData;
  }catch(error) {
    throw Exception(error);
  }
}

Future<List<DeudaModel>> getDeudasUser(String idUser) async {
  try {
    final snapshot = await db.collection("deudas").where("uid",isEqualTo: idUser).get();
    final deudaData = snapshot.docs.map((e) => DeudaModel.fromSnapshot(e)).toList();
    return deudaData;
  }catch(error) {
    throw Exception(error);
  }
}

void pagar(idDeuda, nCuota) {
  try {
    final deudaRef = db.collection("deudas").doc(idDeuda);
    deudaRef.update({
      "n_cuota": nCuota - 1,
    });
  } catch(error) {
    throw Exception(error);
  }
}

void eliminar(idDeuda) {
  try {
    final deudaRef = db.collection("deudas").doc(idDeuda);
    deudaRef.delete();
  } catch(error) {
    throw Exception(error);
  }
}