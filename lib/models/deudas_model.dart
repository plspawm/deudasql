import 'package:cloud_firestore/cloud_firestore.dart';

class DeudaModel {
  final String? id;
  final String nombreDeuda;
  final int nCuota;
  final Timestamp fechaPago;
  final Timestamp fechaProximaPago;

  const DeudaModel(
      {this.id,
      required this.nCuota,
      required this.nombreDeuda,
      required this.fechaPago,
      required this.fechaProximaPago});

  toJson() {
    return {
      "nombre_deuda": nombreDeuda,
      "n_cuota": nCuota,
      "fecha_pago": fechaPago,
      "fecha_proximo_pago": fechaProximaPago,
    };
  }

  factory DeudaModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return DeudaModel(
        id: document.id,
        nCuota: data["n_cuota"],
        nombreDeuda: data["nombre_deuda"],
        fechaPago: data["fecha_pago"],
        fechaProximaPago: data["fecha_proximo_pago"]);
  }
}
