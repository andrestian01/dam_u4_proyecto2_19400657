import 'package:dam_u4_proyecto2_19400657/actualizar/actualizarAsignacion.dart';
import 'package:dam_u4_proyecto2_19400657/services/asignacion.dart';
import 'package:dam_u4_proyecto2_19400657/services/firebase_service.dart';
import 'package:dam_u4_proyecto2_19400657/capturar/capturarAsignacion.dart';
import "package:flutter/material.dart";

class programaAsignacion extends StatefulWidget {
  const programaAsignacion({Key? key}) : super(key: key);

  @override
  State<programaAsignacion> createState() => _programaAsignacionState();
}

class _programaAsignacionState extends State<programaAsignacion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 20),
          Expanded(
            child: FutureBuilder(
              future: getAsignacion(),
              builder: ((context, snapshot) {
                return ListView.separated(
                    itemCount: snapshot.hasData ? snapshot.data!.length : 0,
                    separatorBuilder: (BuildContext context, int index) =>
                        Divider(color: Color.fromARGB(255, 164, 211, 232)),
                    itemBuilder: (context, index) {
                      if (snapshot.hasData) {
                        return InkWell(
                          child: ListTile(
                            leading: Icon(Icons.class_outlined),
                            title: Text(
                                "${snapshot.data?[index]['materia']}    ${snapshot.data?[index]['horario']}   "),
                            subtitle: Text(
                                " ${snapshot.data?[index]['docente']} \n Edificio: ${snapshot.data?[index]['edificio']}   Salón:${snapshot.data?[index]['salon']} \n  "),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                    icon: Icon(Icons.edit,
                                        color: Color(0xFF667761)),
                                    onPressed: () async {
                                      await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => ActualizarAsig(
                                                  as: Asignacion(
                                                      docente:
                                                          snapshot.data?[index]
                                                              ['docente'],
                                                      edificio:
                                                          snapshot.data?[index]
                                                              ['edificio'],
                                                      horario:
                                                          snapshot.data?[index]
                                                              ['horario'],
                                                      materia:
                                                          snapshot.data?[index]
                                                              ['materia'],
                                                      salon:
                                                          snapshot.data?[index]
                                                              ['salon'],
                                                      aid: snapshot.data?[index]
                                                          ['aid']))));
                                      setState(() {});
                                    }),
                                IconButton(
                                    icon: Icon(Icons.delete,
                                        color: Color.fromARGB(
                                            255, 130, 168, 116)),
                                    onPressed: () {
                                      alert(index, snapshot);
                                    }),
                              ],
                            ),
                          ),
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    });
              }),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(context,
                  MaterialPageRoute(builder: (builder) => CapturarAsig()))
              .then((value) => setState(() {}));
          //setState((){});
          //actPlacas();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void alert(int index, AsyncSnapshot<dynamic> snapshot) {
    showDialog(
        context: context,
        builder: (builder) {
          return AlertDialog(
            title: Text("ATENCION"),
            content: Text(
                "¿Seguro que desea eliminar a ${snapshot.data?[index]['docente']}?"),
            actions: [
              TextButton(
                  onPressed: () async {
                    await eliminarAsignacion(snapshot.data?[index]['aid'])
                        .then((_) => setState(() {}));
                    Navigator.pop(context);
                  },
                  child: Text("Sí")),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancelar")),
            ],
          );
        });
  }
}
