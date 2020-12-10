import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'alimentos.dart';
import 'package:http/http.dart' as http; //Paquete para usar http
import 'dart:convert'; //Paquete de dart
import 'package:google_fonts/google_fonts.dart';

class PantallaBuscados extends StatefulWidget { 
  final String alimentoAmostrarNombre; 
  PantallaBuscados ({this.alimentoAmostrarNombre}); 
  @override 
  _PantallaBuscadosEstado createState() => _PantallaBuscadosEstado(alimentoAmostrar: alimentoAmostrarNombre); //Los parametros que pide 
}
Widget  fav= Icon(Icons.favorite_border);
List<Widget> alimentosBuscados = []; 

class _PantallaBuscadosEstado extends State<PantallaBuscados> { 
  String alimentoAmostrar;
  void buscarAlimento(var nombreAlimento){ 
  http.get('https://biblioteca-f5d65.firebaseio.com/alimentos.json').then((http.Response respuesta){ 
    List<Widget> listaAlimentosBuscados = []; 
    final Map<String, dynamic> listaDatosAlimentos= json.decode(respuesta.body); // Se genera un mapa con los datos decodificados del cuerpo de la respuesta
    listaDatosAlimentos.forEach((String id, dynamic datosAlimentos){ 
      final Alimento alimento = Alimento(
        id: id,
        nombre: datosAlimentos['nombre'], 
        porcion: datosAlimentos['porcion'],
        carbos: datosAlimentos['carbos'],
        proteinas: datosAlimentos['proteinas'],
        grasas: datosAlimentos['grasas'],
        urlImg: datosAlimentos['url'],
        presionado: false, 
      );
      if(nombreAlimento == datosAlimentos['nombre'] || nombreAlimento == "" ) {
        listaAlimentosBuscados.add(
          Container(
                  height: 140.0,
                  child: Card( 
                  shadowColor: Colors.lime,
                  child: Column(children: [
                    ListTile( 
                  subtitle: Text("Porción: " + alimento.porcion, style: GoogleFonts.varelaRound(fontSize: 13.0, color: Colors.grey),),//Subtitulo
                  title: new Text(alimento.nombre), 
                  leading: new Image.network(alimento.urlImg), 
                  trailing: SingleChildScrollView( 
                    scrollDirection: Axis.horizontal, 
                    child: Row( 
                    mainAxisAlignment: MainAxisAlignment.end, 
                    children: <Widget>[ 
                      IconButton(
                        icon: (alimento.presionado ? Icon(Icons.favorite) : Icon(Icons.favorite_border)),
                        color: Colors.lime[200],
                        onPressed: (){
                          setState(() {
                          alimento.cambiarFav(); 
                          addAlimentoFav(alimento);
                          });
                          
                        }
                    ),
                   ]),
                )),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [                
                    Text("Carbohidratos: " + alimento.carbos, style: GoogleFonts.varelaRound(fontSize: 13.0, color: Colors.grey),),
                    Text("Proteinas: " + alimento.proteinas, style: GoogleFonts.varelaRound(fontSize: 13.0, color: Colors.grey),),
                    Text("Grasas: " + alimento.grasas, style: GoogleFonts.varelaRound(fontSize: 13.0, color: Colors.grey),)
                  ]), 
                  ]))
                ));
      }
        
    });
    setState((){ 
      alimentosBuscados= listaAlimentosBuscados; 
    });
  });
}
  _PantallaBuscadosEstado ({this.alimentoAmostrar}); 
  @override
  
  Widget build(BuildContext context) { 
    buscarAlimento(alimentoAmostrar);  
    return Scaffold( 
      appBar: new AppBar(backgroundColor: Colors.lime, title:new Text("Resultados", style: GoogleFonts.varelaRound(fontSize: 18.0, color: Colors.white)), centerTitle: true,), 
      body: Padding( 
      padding: EdgeInsets.fromLTRB(10, 30, 10, 0), 
        child: ListView( 
        children: alimentosBuscados, 
       )));
}
}
