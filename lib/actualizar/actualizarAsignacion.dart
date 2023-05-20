import 'package:dam_u4_proyecto2_19400657/services/asignacion.dart';
import 'package:dam_u4_proyecto2_19400657/capturar/capturarAsignacion.dart';
import 'package:dam_u4_proyecto2_19400657/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class ActualizarAsig extends StatefulWidget {
  final Asignacion as;
  const ActualizarAsig({Key? key, required this.as}) : super(key: key);

  @override
  State<ActualizarAsig> createState() => _ActualizarAsigState();
}

class _ActualizarAsigState extends State<ActualizarAsig> {
  @override
  ActualizarAsig get widget => super.widget;

  @override
  void initState() {
    super.initState();
    act();
  }

  void act() {
    idC.text = super.widget.as.aid!;
    docenteC.text = super.widget.as.docente;
    salonC.text = super.widget.as.salon;
    selectedE = super.widget.as.edificio;
    horarioC.text = super.widget.as.horario;
    selectedM = super.widget.as.materia;
  }

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

  TextEditingController idC = TextEditingController();
  TextEditingController docenteC = TextEditingController();
  TextEditingController salonC = TextEditingController();
  TextEditingController horarioC = TextEditingController();

  var horarioMask = MaskTextInputFormatter(
      mask: '##:##-##:##', filter: {"#": RegExp(r'[0-9]')});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Actualizar Asignación"),
        centerTitle: true,
        backgroundColor: Color(0xFF6DCCA0),
      ),
      body: ListView(
        padding: EdgeInsets.all(30),
        children: [
          TextField(
            controller: docenteC,
            autofocus: true,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.person_3_rounded),
              labelText: "DOCENTE",
            ),
          ),
          TextField(
            controller: horarioC,
            keyboardType: TextInputType.number,
            inputFormatters: [horarioMask],
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.timelapse),
              labelText: "HORARIO",
              hintText: "##-##",
            ),
          ),
          DropdownButtonHideUnderline(
            child: DropdownButton(
              hint: Text('EDIFICIO', style: TextStyle(fontSize: 14)),
              items: _edificio
                  .map(
                    (item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(item, style: TextStyle(fontSize: 14)),
                    ),
                  )
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
              prefixIcon: Icon(Icons.home_work_outlined),
              labelText: "SALON",
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF1AD7A4),
            ),
            onPressed: () async {
              if (docenteC.text.isEmpty ||
                  horarioC.text.isEmpty ||
                  salonC.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Por favor, llene todos los campos.")),
                );
              } else {
                Asignacion as = Asignacion(
                  materia: materiaC.text, // Utiliza el valor del TextField
                  docente: docenteC.text,
                  horario: horarioC.text,
                  edificio: selectedE.toString(),
                  salon: salonC.text,
                );

                await actualizarAsignacion(as, idC.text).then((value) {
                  if (value > 0) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("ACTUALIZADO CORRECTAMENTE!")),
                    );
                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text("ERROR al actualizar la asignacion")),
                    );
                  }
                });
              }
            },
            child: Text("ACTUALIZAR"),
          ),
        ],
      ),
    );
  }
}
