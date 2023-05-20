import 'package:dam_u4_proyecto2_19400657/services/asistencia.dart';
import 'package:dam_u4_proyecto2_19400657/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class programaAsistencia extends StatefulWidget {
  const programaAsistencia({Key? key}) : super(key: key);

  @override
  State<programaAsistencia> createState() => _programaAsistenciaState();
}

String getFormattedCurrentDate() {
  final now = DateTime.now();
  final formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
  final formattedDate = formatter.format(now);
  return formattedDate;
}

class _programaAsistenciaState extends State<programaAsistencia> {
  List<String> _docente = [];
  int interfaz = 0;
  String? selectedD;
  final List<String> _edificio = [
    'Edificio A',
    'Edificio A°',
    'Edificio AD',
    'Edificio B',
    'Edificio B°',
    'Edificio BG',
    'Edificio CB',
    'Edificio DB',
    'Edificio EE',
    'Edificio F',
    'Edificio G',
    'Edificio GR',
    'Edificio H',
    'Edificio J',
    'Edificio K',
    'Edificio L',
    'Edificio LC',
    'Edificio LIIA',
    'Edificio LICBI',
    'Edificio N',
    'Edificio P',
    'Edificio P°',
    'Edificio Q',
    'Edificio Q°',
    'Edificio UD',
    'Edificio UVP',
    'Edificio X'
  ];
  String? selectedE;
  TextEditingController buscarD = TextEditingController();
  TextEditingController buscarE = TextEditingController();
  TextEditingController fechafinC = TextEditingController();
  TextEditingController fechainiC = TextEditingController();

  var dateMask = MaskTextInputFormatter(
      mask: '####/##/##', filter: {'#': RegExp(r'[0-9]')});

  @override
  void initState() {
    super.initState();
    fetchDocentes();
  }

  Future<void> fetchDocentes() async {
    await getDocentes().then((docentes) {
      setState(() {
        _docente = docentes;
      });
    });
  }

  String convertAsistenciaToString(List<Map<String, dynamic>> asistencia) {
    String result = '';

    asistencia.forEach((map) {
      String fecha = map['fecha'] ?? '';
      String supervisor = map['revisor'] ?? '';
      result += '* $fecha\n   Revisor: $supervisor\n';
    });

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 20),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.replay_outlined, color: Color(0xFF667761)),
                onPressed: () {
                  setState(() {
                    interfaz = 0;
                  });
                },
                tooltip: 'Recargar',

              ),
              SizedBox(width: 15),
              Expanded(
                child: Row(
                  children: [
                    Icon(Icons.search_off_outlined),
                    SizedBox(width: 8),
                    Expanded(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          hint: Text('Filtrar por docente',
                              style: TextStyle(fontSize: 14)),
                          items: _docente
                              .map(
                                (item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ),
                              )
                              .toList(),
                          value: selectedD,
                          onChanged: (value) {
                            setState(() {
                              selectedD = value as String;
                              buscarD.text = selectedD!;
                              interfaz = 1;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ), // Filtrar por docente
              SizedBox(width: 15),
              Expanded(
                child: Row(
                  children: [
                    Icon(Icons.search_off_outlined),
                    SizedBox(width: 8),
                    Expanded(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          hint: Text('Filtrar por edificio',
                              style: TextStyle(fontSize: 14)),
                          items: _edificio
                              .map(
                                (item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ),
                              )
                              .toList(),
                          value: selectedE,
                          onChanged: (value) {
                            setState(() {
                              selectedE = value as String;
                              buscarE.text = selectedE!;
                              interfaz = 2;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ), // Filtrar por edificio
              SizedBox(width: 15),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    showDateFilter();
                  });
                },
                child: Text("Filtrar por fecha"),
              ),
              SizedBox(width: 15),
            ],
          ),
          SizedBox(height: 15),
          Expanded(
            child: FutureBuilder(
              future: interfaz == 0
                  ? getAsignacion()
                  : interfaz == 1
                      ? getAsisDocente(buscarD.text)
                      : interfaz == 2
                          ? getAsisEdificio(buscarE.text)
                          : getAsignacionByDate(fechainiC.text, fechafinC.text),
              builder: ((context, snapshot) {
                return ListView.separated(
                    itemCount: snapshot.hasData ? snapshot.data!.length : 0,
                    separatorBuilder: (BuildContext context, int index) =>
                        Divider(color: Color(0xFF8CC0DE)),
                    itemBuilder: (context, index) {
                      if (snapshot.hasData) {
                        return InkWell(
                          onTap: () {
                            showModalAsistencia(index, snapshot);
                          },
                          child: ListTile(
                            leading: Icon(Icons.assignment),
                            title: Text(
                                "${snapshot.data?[index]['docente']}   Edificio:${snapshot.data?[index]['edificio']}  "),
                            subtitle: Text(
                                "${convertAsistenciaToString(snapshot.data?[index]['asistencias'])} "),
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
    );
  }

  void showModalAsistencia(int index, AsyncSnapshot<List> snapshot) {
    final revisorController = TextEditingController();
    final idController = TextEditingController();

    idController.text = snapshot.data?[index]['aid'];

    showModalBottomSheet(
      elevation: 20,
      context: context,
      isScrollControlled: true,
      builder: (builder) {
        return Container(
          padding: EdgeInsets.only(
            top: 15,
            left: 30,
            right: 30,
            bottom: MediaQuery.of(context).viewInsets.bottom + 30,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Insertar Revisor"),
              SizedBox(height: 10),
              TextField(
                controller: revisorController,
                decoration: InputDecoration(labelText: "REVISOR"),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  Asistencia asistencia = Asistencia(
                    fecha: getFormattedCurrentDate(),
                    revisor: revisorController.text,
                  );
                  await insertarAsistencia(asistencia, idController.text);
                  setState(() {});
                  Navigator.pop(context);
                },
                child: Text("Guardar Cambios"),
              ),
            ],
          ),
        );
      },
    );
  }

  void showDateFilter() {
    final startDateController = TextEditingController();
    final endDateController = TextEditingController();

    showModalBottomSheet(
      elevation: 20,
      context: context,
      isScrollControlled: true,
      builder: (builder) {
        return Container(
          padding: EdgeInsets.only(
            top: 15,
            left: 30,
            right: 30,
            bottom: MediaQuery.of(context).viewInsets.bottom + 30,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Filtrar por rango de fechas"),
              SizedBox(height: 10),
              TextField(
                controller: startDateController,
                keyboardType: TextInputType.number,
                inputFormatters: [dateMask],
                style: TextStyle(fontSize: 15),
                decoration: InputDecoration(
                  hintText: "2023/11/04",
                  labelText: "Fecha Inicio",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.event_available),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: endDateController,
                keyboardType: TextInputType.number,
                inputFormatters: [dateMask],
                style: TextStyle(fontSize: 15),
                decoration: InputDecoration(
                  hintText: "2023/11/07",
                  labelText: "Fecha Fin",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.event_available),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    getAsignacionByDate(
                        startDateController.text, endDateController.text);
                  });
                  Navigator.pop(context);
                },
                child: Text("Buscar"),
              ),
            ],
          ),
        );
      },
    );
  }
}
