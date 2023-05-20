import 'package:dam_u4_proyecto2_19400657/services/asistencia.dart';

class Asignacion {
  String? aid;
  String docente;
  String edificio;
  String horario;
  String materia;
  String salon;
  List<Asistencia>? asistencia;

  Asignacion(
      {this.aid,
      required this.docente,
      required this.edificio,
      required this.horario,
      required this.materia,
      required this.salon,
      this.asistencia});

  Map<String, dynamic> toMap() {
    return {
      'docente': docente,
      'edificio': edificio,
      'horario': horario,
      'materia': materia,
      'salon': salon
    };
  }
}
