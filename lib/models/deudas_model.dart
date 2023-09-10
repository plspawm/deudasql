import 'package:cloud_firestore/cloud_firestore.dart';

class DeudaModel {
  final String? id;
  final String nombre_deuda;
  final int n_cuota;
  final Timestamp fecha_pago;

  const DeudaModel(
      {this.id,
      required this.n_cuota,
      required this.nombre_deuda,
      required this.fecha_pago});

  toJson() {
    return {
      "nombre_deuda": nombre_deuda,
      "n_cuota": n_cuota,
      "fecha_pago": fecha_pago
    };
  }

  factory DeudaModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return DeudaModel(
        id: document.id,
        n_cuota: data["n_cuota"],
        nombre_deuda: data["nombre_deuda"],
        fecha_pago: data["fecha_pago"]);
  }
}
