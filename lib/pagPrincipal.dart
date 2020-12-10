import 'package:appbaier2/pagBuscar.dart';
import 'package:appbaier2/pagInicioSesion.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'pagSubir.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http; //Paquete para usar http
import 'dart:convert'; //Paquete de dart
import 'alimentos.dart';
import 'favoritos.dart';



class PagPrincipal extends StatefulWidget{
  final User user;

  const PagPrincipal({Key key, this.user}) : super(key: key);
  @override 
  _PagPrincipalState createState() => _PagPrincipalState();
}

class _PagPrincipalState extends State<PagPrincipal>{
  @override 
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: new CuerpoPrincipal());
  }

}

Widget  fav= Icon(Icons.favorite_border); 
class CuerpoPrincipal extends StatefulWidget{
  @override 
  _CuerpoPrincipalState createState()=> _CuerpoPrincipalState();
}
List<Icon> iconos= []; 
List<Widget> alimentos= []; 
class _CuerpoPrincipalState extends State<CuerpoPrincipal> {
  TextEditingController nombreAlimentoBuscado = TextEditingController();
  void buscarAlimento(){ 
  http.get('https://biblioteca-f5d65.firebaseio.com/alimentos.json').then((http.Response respuesta){ 
    List<Widget> listaAlimentosBuscados = []; 
    Map<String, dynamic> listaDatosAlimentos= json.decode(respuesta.body); 
    listaDatosAlimentos.forEach((String id, dynamic datosAlimentos){ 
      Alimento alimento = Alimento(
        id: id,
        nombre: datosAlimentos['nombre'], 
        porcion: datosAlimentos['porcion'],
        carbos: datosAlimentos['carbos'],
        proteinas: datosAlimentos['proteinas'],
        grasas: datosAlimentos['grasas'],
        urlImg: datosAlimentos['url'],
        presionado: false, 
      ); 
      
      Icon icono= (alimento.presionado)?  Icon(Icons.favorite, color: Colors.red,):Icon(Icons.favorite_border); //Para que camabie a un corazón relleno
      iconos.add(icono); 
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
    });
    setState((){
      alimentos= listaAlimentosBuscados; 
    });
  });
} 
 
  @override 
  Widget build(BuildContext context) { //Constructor
    buscarAlimento(); 
    return Scaffold( 
      drawer: Menu(),
      appBar: AppBar(
        backgroundColor: Colors.lime,
        title: new Text('NutriSide', style: GoogleFonts.varelaRound(fontSize: 18.0, color: Colors.white)),
        actions: [IconButton(icon: Icon(Icons.search), onPressed: (){
          Navigator.push( 
              context,
              MaterialPageRoute(builder: (context) => PantallaBuscarAlimentos())); 
            })],),
      body: ListView( 
            children: alimentos, 
            ),
          );
}
}

class Menu extends StatelessWidget{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: ListView(
        children: <Widget>[
          new Container(
            height: 130.0,
              child: Center(
                child: Text(
                  "Usuario", 
                  style: GoogleFonts.varelaRound(fontSize: 18.0, color: Colors.white),
                ),
              ),           
            decoration: BoxDecoration(
            color: Colors.lime,
            ),
          ),
          new ListTile(
            leading: Icon(Icons.favorite_border, color: Colors.lime),
            title: Text("Favoritos", style: GoogleFonts.varelaRound(fontSize: 18.0),),
            onTap: (){
              Navigator.push(
            context,
            new MaterialPageRoute(builder: (context) => new PantallaFav()));
            },
          ),
           new ListTile(
            leading: Icon(Icons.my_library_books_outlined, color: Colors.lime),
            title: Text("Carpetas", style: GoogleFonts.varelaRound(fontSize: 18.0),),
            onTap: (){},
          ),
           new ListTile(
            leading: Icon(Icons.upload_outlined, color: Colors.lime),
            title: Text("Subir alimento", style: GoogleFonts.varelaRound(fontSize: 18.0),),
            onTap: (){
              Navigator.push(
            context,
            new MaterialPageRoute(builder: (context) => new PagSubir()));
            },
          ),
           new ListTile(
            leading: Icon(Icons.logout, color: Colors.lime),
            title: Text("Cerrar Sesión", style: GoogleFonts.varelaRound(fontSize: 18.0),),
            onTap: (){
              _cerrarSesion().whenComplete((){
                Navigator.push(
                context,
                new MaterialPageRoute(builder: (context) => new InicioSesion()));
              });
            },
          ),
        ],
      ) ,
      ),
    );
  }
  Future _cerrarSesion() async{
  await _auth.signOut();
  }
}

