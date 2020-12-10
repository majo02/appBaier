import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'pagPrincipal.dart';
import 'pagRegistro.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class InicioSesion extends StatefulWidget{
  @override
  _InicioState createState()=> _InicioState();
}

class _InicioState extends State<InicioSesion>{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formInicioKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController emailInicioControl= new TextEditingController();
  TextEditingController passInicioControl= new TextEditingController();
  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        padding: EdgeInsets.only(top: 50.0),
        child: ListView(
          children: <Widget>[
          Image.asset("assets/logo.png", width: 150, height: 150), SizedBox(height: 50.0,),inicioUi()
          ]
        ),
        ),
    );
  }
Widget inicioUi(){
  return Form(
      key: _formInicioKey,
      child: Card(
          child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[        
        TextFormField(
          controller: emailInicioControl,
          autofocus: false,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.account_box,),
            hintText: 'Correo electrónico',          
          ),
          validator: (String val){
            if(val.isEmpty){
              return "Ingrese un correo";
            }
            return null;
          }
        ),
        TextFormField(
          controller: passInicioControl,
          autofocus: false,
          obscureText: true,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.lock,),
            hintText: 'Contraseña',          
          ),
          validator: (String val){
            if(val.isEmpty){
              return "Ingrese una contraseña";
            }
            return null;
          }
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.center,
          child: MaterialButton(
          onPressed:() async{
            if(_formInicioKey.currentState.validate()){
              iniciarUsuario();
            }
          },
          child: Text ('Ingresar',style: GoogleFonts.varelaRound(fontSize: 18.0,color: Colors.lime),) 
          ),
          ),
        Container(
          alignment: Alignment.center,
          child: FlatButton(
            child: Text("¿No estas registrado?", style: GoogleFonts.varelaRound(fontSize: 12.0,color: Colors.lime)),
            onPressed: (){
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
                return Registro();
              }));
            },
          ),
          ),
        ],)
        )
        ),
      );
}
void iniciarUsuario() async{
  try{
    //Tiene que ser un email verdadero
    final User user = (await _auth.signInWithEmailAndPassword(email: emailInicioControl.text, password: passInicioControl.text)).user; 
      if(!user.emailVerified){
      await user.sendEmailVerification();
    }else{
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
      return PagPrincipal(user: user);
      }));
    }
    }catch(e){
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Verifique su correo primero.")));
  }
  }
}