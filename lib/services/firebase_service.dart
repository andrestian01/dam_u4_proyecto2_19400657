import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dam_u4_proyecto2_19400657/services/asignacion.dart';
import 'package:dam_u4_proyecto2_19400657/services/asistencia.dart';
import 'package:intl/intl.dart';

final FirebaseFirestore db = FirebaseFirestore.instance;
final CollectionReference crAsignacion = db.collection('asignacion');
final CollectionReference crAsis = db.collection('asistencia');

Future<List<Map<String, dynamic>>> getAsignacion() async {
  final List<Map<String, dynamic>> asignacion = [];

  final QuerySnapshot qAsig = await crAsignacion.get();

  await Future.forEach(qAsig.docs, (documento) async {
    final List<Map<String, dynamic>> asistencias = [];

    final QuerySnapshot qAsis =
        await crAsignacion.doc(documento.id).collection('asistencia').get();
    await Future.forEach(qAsis.docs, (asisDocumento) async {
      final Map<String, dynamic> asisData =
          asisDocumento.data() as Map<String, dynamic>;
      asistencias.add(asisData);
    });
    final Map<String, dynamic> ids = {'aid': documento.id};
    final Map<String, dynamic> cont = documento.data() as Map<String, dynamic>;
    final Map<String, dynamic> asis = {'asistencias': asistencias};
    ids.addAll(cont);
    ids.addAll(asis);
    asignacion.add(ids);
  });

  return asignacion;
}

Future<int> insertarAsignacion(Asignacion a) async {
  try {
    final DocumentReference asig = await crAsignacion.add(a.toMap());
    final CollectionReference crAsis = asig.collection('asistencias');
    return 1;
  } catch (e) {
    return 0;
  }
}

Future<int> actualizarAsignacion(Asignacion a, String id) async {
  await crAsignacion.doc(id).set(a.toMap());
  return 1;
}

Future<void> eliminarAsignacion(String p) async {
  await crAsignacion.doc(p).delete();
}

Future<void> insertarAsistencia(Asistencia ast, String id) async {
  final DocumentReference asis = await crAsignacion.doc(id);
  await asis.collection('asistencia').add(ast.toMap());
}

Future<List<String>> getDocentes() async {
  final List<String> docentes = [];
  final QuerySnapshot query = await crAsignacion.get();
  query.docs.forEach((doc) {
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    final String docente = data['docente'];

    // Verificar si el docente ya existe en la lista
    if (!docentes.contains(docente)) {
      docentes.add(docente);
    }
  });
  return docentes;
}

Future<List<Map<String, dynamic>>> getAsisDocente(String docente) async {
  final List<Map<String, dynamic>> asignacion = [];

  final QuerySnapshot qAsig =
      await crAsignacion.where('docente', isEqualTo: docente).get();

  await Future.forEach(qAsig.docs, (documento) async {
    final List<Map<String, dynamic>> asistencias = [];

    final QuerySnapshot qAsis =
        await crAsignacion.doc(documento.id).collection('asistencia').get();
    await Future.forEach(qAsis.docs, (asisDocumento) async {
      final Map<String, dynamic> asisData =
          asisDocumento.data() as Map<String, dynamic>;
      asistencias.add(asisData);
    });
    final Map<String, dynamic> ids = {'aid': documento.id};
    final Map<String, dynamic> cont = documento.data() as Map<String, dynamic>;
    final Map<String, dynamic> asis = {'asistencias': asistencias};
    ids.addAll(cont);
    ids.addAll(asis);
    asignacion.add(ids);
  });

  return asignacion;
}

Future<List<Map<String, dynamic>>> getAsisEdificio(String edificio) async {
  final List<Map<String, dynamic>> asignacion = [];

  final QuerySnapshot qAsig =
      await crAsignacion.where('edificio', isEqualTo: edificio).get();

  await Future.forEach(qAsig.docs, (documento) async {
    final List<Map<String, dynamic>> asistencias = [];

    final QuerySnapshot qAsis =
        await crAsignacion.doc(documento.id).collection('asistencia').get();
    await Future.forEach(qAsis.docs, (asisDocumento) async {
      final Map<String, dynamic> asisData =
          asisDocumento.data() as Map<String, dynamic>;
      asistencias.add(asisData);
    });
    final Map<String, dynamic> ids = {'aid': documento.id};
    final Map<String, dynamic> cont = documento.data() as Map<String, dynamic>;
    final Map<String, dynamic> asis = {'asistencias': asistencias};
    ids.addAll(cont);
    ids.addAll(asis);
    asignacion.add(ids);
  });

  return asignacion;
}

Future<List<Map<String, dynamic>>> getAsignacionByDate(
    String fi, String ff) async {
  final List<Map<String, dynamic>> asignacion = [];
  final DateFormat formatter = DateFormat('yyyy/MM/dd');

  final DateTime fechaInicial = formatter.parse(fi);
  final DateTime fechaFinal = formatter.parse(ff);

  final QuerySnapshot qAsig = await crAsignacion.get();

  await Future.wait(qAsig.docs.map((documento) async {
    final List<Map<String, dynamic>> asistencias = [];

    final QuerySnapshot qAsis =
        await crAsignacion.doc(documento.id).collection('asistencia').get();

    await Future.wait(qAsis.docs.map((asisDocumento) async {
      final Map<String, dynamic> asisData =
          asisDocumento.data() as Map<String, dynamic>;
      final String fechaHora = asisData['fecha'];
      final String fechaSplit = fechaHora.split(' ')[0];
      final DateTime fecha = DateTime.parse(fechaSplit);

      if (fecha.isAfter(fechaInicial) && fecha.isBefore(fechaFinal)) {
        asistencias.add(asisData);
      }
    }));

    final Map<String, dynamic> ids = {'aid': documento.id};
    final Map<String, dynamic> cont = documento.data() as Map<String, dynamic>;
    final Map<String, dynamic> asis = {'asistencias': asistencias};
    ids.addAll(cont);
    ids.addAll(asis);

    if (asistencias.isNotEmpty) {
      asignacion.add(ids);
    }
  }));

  return asignacion;
}
