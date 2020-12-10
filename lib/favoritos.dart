import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'alimentos.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class PantallaFav extends StatefulWidget { 
  @override
  _PantallaFavEstado createState() => _PantallaFavEstado(); 
}
List<Widget> alimentosFavs = []; 

class _PantallaFavEstado extends State<PantallaFav> { 
  void buscarAlimentoFavorito(){ 
  http.get('https://biblioteca-f5d65.firebaseio.com/favoritos.json').then((http.Response respuesta){ 
    List<Widget> listaAlimentosBuscados = []; 
    final Map<String, dynamic> listaDatosAlimentos= json.decode(respuesta.body); 
    listaDatosAlimentos.forEach((String id, dynamic datosAlimentos){ 
      final Alimento alimento = Alimento(
        id: id,
        nombre: datosAlimentos['nombre'], 
        porcion: datosAlimentos['porcion'],
        carbos: datosAlimentos['carbos'],
        proteinas: datosAlimentos['proteinas'],
        grasas: datosAlimentos['grasas'],
        urlImg: datosAlimentos['url'],
      );
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
                  trailing: IconButton(icon: Icon(Icons.delete_outline, color: Colors.lime), 
                onPressed: (){ 
                  borrarAlimentoFav(alimento.id);           
                },),),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [                
                    Text("Carbohidratos: " + alimento.carbos, style: GoogleFonts.varelaRound(fontSize: 13.0, color: Colors.grey),),
                    Text("Proteinas: " + alimento.proteinas, style: GoogleFonts.varelaRound(fontSize: 13.0, color: Colors.grey),),
                    Text("Grasas: " + alimento.grasas, style: GoogleFonts.varelaRound(fontSize: 13.0, color: Colors.grey),)
                  ]), 
                  ]))
                )
              );
    }); 
    setState((){ 
      alimentosFavs= listaAlimentosBuscados; 
    });
  });
}

  @override 
  Widget build(BuildContext context) { 
    buscarAlimentoFavorito(); 
    return Scaffold( 
      appBar: new AppBar(backgroundColor: Colors.lime, title:new Text("Favoritos"), centerTitle: true,),
      body: Padding( 
        padding: EdgeInsets.fromLTRB(10, 30, 10, 0), 
          child: ListView( 
          children: alimentosFavs, 
      )));

}
}