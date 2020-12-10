import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'buscarPorVoz.dart';
import 'pagBuscados.dart';

class PantallaBuscarAlimentos extends StatefulWidget { 
  PantallaBuscarAlimentos(); //Instancia 
  @override 
  _PantallaBuscarAlimentosEstado createState() => _PantallaBuscarAlimentosEstado(); 
}

class _PantallaBuscarAlimentosEstado extends State<PantallaBuscarAlimentos> { 
  TextEditingController nombreAlimentoBuscado = TextEditingController(); 
  @override 
  Widget build(BuildContext context) { //Constructor
    return Scaffold( 
      appBar: AppBar(
        backgroundColor: Colors.lime,
        title: new Padding(padding: EdgeInsets.only(left: 70.0),child: Text('NutriSide', style: GoogleFonts.varelaRound(fontSize: 18.0, color: Colors.white)),)
        ),
      body: LayoutBuilder( //Crea un árbol de widgets que puede depender del tamaño del widget principal.
      builder: (BuildContext context, BoxConstraints restricciones) { 
      return SingleChildScrollView( //Para que la pantalla sea scrolleable
        child: ConstrainedBox(// Widget que impone las restricciones de BoxConstrains.
          constraints: BoxConstraints( 
            minHeight: restricciones.maxHeight,
          ),
          child:Container( 
      decoration: BoxDecoration( 
        color: Colors.white
      ),
      child:  new Column( 
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[ 
           Padding( 
              padding:EdgeInsets.fromLTRB(10, 30, 10, 0), 
              child: Column( 
            children: <Widget>[ 
            Padding( 
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0), 
              child: TextFormField(
          controller: nombreAlimentoBuscado,
          autofocus: false,
          decoration: InputDecoration(
            hintText: 'Nombre del alimento',          
          ),
        ),
            ),
            new SizedBox(
              height: 15.0, 
            ),
          Container( 
          alignment: Alignment.bottomCenter, 
          margin: EdgeInsets.only(left: 125.0), 
          child: Row(
            children: [
              IconButton( 
              onPressed: () { 
                setState(() { //Avisa al framework de los cambios
                  Navigator.push( 
                    context,
                    MaterialPageRoute(builder: (context) => PantallaBuscados(alimentoAmostrarNombre: nombreAlimentoBuscado.text))); //Clase con los alimentos
                });
              },
              icon: Icon(Icons.search, size: 35.0), 
              color: Colors.lime,
            ),
            IconButton( 
              onPressed: () { 
                setState(() { //Avisa al framework de los cambios
                  Navigator.push(
                    context,
                    new MaterialPageRoute(builder: (context) => new BuscarPorVoz()));
                });
              },
              icon: Icon(Icons.mic, size: 35.0), 
              color: Colors.lime,
            ),
            ]
          ),
        ),
           ]))
           ],
              ),
        ),),);}),);
  }
}