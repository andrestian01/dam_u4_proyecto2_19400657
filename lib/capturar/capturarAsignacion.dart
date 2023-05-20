import 'package:dam_u4_proyecto2_19400657/services/asignacion.dart';
import 'package:dam_u4_proyecto2_19400657/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CapturarAsig extends StatefulWidget {
  const CapturarAsig({Key? key}) : super(key: key);

  @override
  State<CapturarAsig> createState() => _CapturarAsigState();
}

final docenteC = TextEditingController();
final salonC = TextEditingController();
final horarioC = TextEditingController();
final edificioC = TextEditingController();
final materiaC = TextEditingController();

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
String? selectedM;

var horarioMask =
    MaskTextInputFormatter(mask: '##:##', filter: {"#": RegExp(r'[0-9]')});

class _CapturarAsigState extends State<CapturarAsig> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Insertar Asignación"),
        centerTitle: true,
        backgroundColor: Color(0xFF06AB78),
      ),
      body: ListView(
        padding: EdgeInsets.all(30),
        children: [
          TextField(
            controller: materiaC,
            autofocus: true,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.book),
              labelText: "MATERIA",
            ),
          ),
          TextField(
              controller: docenteC,
              autofocus: true,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person), labelText: "DOCENTE")),
          TextField(
              controller: horarioC,
              keyboardType: TextInputType.number,
              inputFormatters: [horarioMask],
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.timelapse),
                  labelText: "HORARIO",
                  hintText: "##:##")),
          DropdownButtonHideUnderline(
            child: DropdownButton(
              hint: Text('EDIFICIO', style: TextStyle(fontSize: 14)),
              items: _edificio
                  .map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(item, style: TextStyle(fontSize: 14))))
                  .toList(),
              value: selectedE,
              onChanged: (value) {
                setState(() {
                  selectedE = value as String;
                  edificioC.text = selectedE!;
                });
              },
            ),
          ),
          TextField(
              controller: salonC,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.business_outlined),
                  labelText: "SALON")),
          SizedBox(height: 20),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Color.fromARGB(255, 109, 204, 160), // Color de fondo del botón
              ),
              onPressed: () async {
                if (materiaC.text.isEmpty ||
                    docenteC.text.isEmpty ||
                    horarioC.text.isEmpty ||
                    edificioC.text.isEmpty ||
                    salonC.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Por favor, llene todos los campos.")));
                } else {
                  Asignacion as = Asignacion(
                      materia: materiaC.text,
                      docente: docenteC.text,
                      horario: horarioC.text,
                      edificio: edificioC.text,
                      salon: salonC.text,
                      asistencia: []);

                  await insertarAsignacion(as).then((value) {
                    if (value > 0) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("INSERTADO CON EXITO!")));
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("ERROR al insertar la asignacion")));
                    }
                  });
                }
                salonC.text = "";
                edificioC.text = "";
                horarioC.text = "";
                docenteC.text = "";
                materiaC.text = "";
              },
              child: Text("INSERTAR"))
        ],
      ),
    );
  }
}
