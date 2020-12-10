import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'alimentos.dart';
import 'pagPrincipal.dart';



class PagSubir extends StatelessWidget{
  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      //endDrawer: IconButton(icon: Icon(Icons.search_outlined), onPressed: (){}),
      appBar: AppBar(
        leading: Icon(Icons.add),
        backgroundColor: Colors.lime,
        title: Text(" Subir Alimento", style: GoogleFonts.varelaRound(fontSize: 18.0,color: Colors.white), ),
      ),
      body: CuerpoSubir(),
    );
  }
}





class CuerpoSubir extends StatefulWidget{
  @override 
  _CuerpoSubirState createState()=> _CuerpoSubirState();
}

class _CuerpoSubirState extends State<CuerpoSubir>{
  TextEditingController nombreAlimento, porcion, carbohidratos, proteinas, grasas, urlAlimento; 
  final GlobalKey<FormState> _formInicioKey = GlobalKey<FormState>();
  @override
  void initState(){
    super.initState();
    nombreAlimento= new TextEditingController();
    porcion= new TextEditingController();
    carbohidratos= new TextEditingController();
    proteinas= new TextEditingController();
    grasas= new TextEditingController();
    urlAlimento= new TextEditingController();
  }
  @override
  Widget build(BuildContext context) {
   return SingleChildScrollView(
     child: Column(
        children: <Widget>[
          Icon(Icons.account_circle, size: 200, color: Colors.white),
          subirUi(),
        ],
   ),);
  }

Widget subirUi(){
  return Builder(
    builder: (context){
    return Form(
      key: _formInicioKey,
      child: Column(
        children: <Widget>[
        TextFormField(
          controller: nombreAlimento,
          autofocus: false,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.emoji_food_beverage_outlined),
            hintText: 'Nombre del alimento',          
          ),
          validator: (String val){
              if(val.isEmpty){
                return "Ingrese un nombre";
              }
              return null;
            }
        ),
        TextFormField(
          controller: porcion,
          autofocus: false,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.donut_small),
            hintText: 'Porción',          
          ),
          validator: (String val){
              if(val.isEmpty){
                return "Ingrese una porción";
              }
              return null;
            }
        ),
        TextFormField(
          controller: carbohidratos,
          autofocus: false,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.fastfood_outlined),
            hintText: 'Carbohidratos',          
          ),
          validator: (String val){
              if(val.isEmpty){
                return "Ingrese carbohidratos";
              }
              return null;
            }
        ),
        TextFormField(
          controller: proteinas,
          autofocus: false,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.emoji_people_outlined),
            hintText: 'Proteinas',         
          ),
          validator: (String val){
              if(val.isEmpty){
                return "Ingrese proteinas";
              }
              return null;
            }
        ),
        TextFormField(
          controller: grasas,
          autofocus: false,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.emoji_nature_outlined),
            hintText: 'Grasas',          
          ),
          validator: (String val){
              if(val.isEmpty){
                return "Ingrese grasas";
              }
              return null;
            }
        ),
        TextFormField(
          controller: urlAlimento,
          autofocus: false,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.emoji_nature_outlined),
            hintText: 'Url Imágen',          
          ),
          validator: (String val){
              if(val.isEmpty){
                return "Ingrese una url";
              }
              return null;
            }
        ),
        SizedBox(height: 10.0),
        MaterialButton(
          onPressed:(){
            if(_formInicioKey.currentState.validate()){
              setState(() { //Avisa al framework que hubieron cambios
              addAlimento(nombreAlimento.text,porcion.text,carbohidratos.text,proteinas.text, grasas.text,urlAlimento.text); //Añade el alimento a la bd.
            });
            Navigator.push(
              context,
              new MaterialPageRoute(builder: (context) => new PagPrincipal()));
            }
          },
          child: Text ('Agregar',style: GoogleFonts.varelaRound(fontSize: 18.0,color: Colors.lime),) 
          ),
      ],),
    );}
  );
}
}
