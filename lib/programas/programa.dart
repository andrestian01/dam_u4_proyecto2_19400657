import 'package:flutter/material.dart';
import 'package:dam_u4_proyecto2_19400657/programas/programaAsignacion.dart';
import 'package:dam_u4_proyecto2_19400657/programas/programaAsistencia.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Interfaz extends StatefulWidget {
  const Interfaz({Key? key}) : super(key: key);

  @override
  State<Interfaz> createState() => _InterfazState();
}

class _InterfazState extends State<Interfaz> {
  int _indice = 0;

  void _cambiarIndice(int indice) {
    setState(() {
      _indice = indice;
    });
  }

  final List<Widget> _paginas = [
    programaAsignacion(),
    programaAsistencia(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Asistencia Tec",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 130, 168, 116),
      ),
      body: _paginas[_indice],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.class_,
              color: Colors.white,
            ),
            label: "Asignaciones",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.timelapse,
              color: Colors.white,
            ),
            label: "Lista de Asistencia",
          ),
        ],
        currentIndex: _indice,
        onTap: _cambiarIndice,
        iconSize: 30,
        showUnselectedLabels: false,
        backgroundColor: Color.fromARGB(255, 130, 168, 116),
        selectedItemColor: Color.fromARGB(255, 250, 255, 253),
        unselectedItemColor: Color.fromARGB(255, 130, 168, 116),
      ),
    );
  }
}
