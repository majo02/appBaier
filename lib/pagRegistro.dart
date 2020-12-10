import 'package:appbaier2/pagInicioSesion.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class Registro extends StatefulWidget{
  @override
  _RegisterState createState()=> _RegisterState();
}

class _RegisterState extends State<Registro>{
  final FirebaseAuth _auth = FirebaseAuth.instance; //Instancia el Firebase Auth para poder usarlo en las funciones de registro
  final GlobalKey<FormState> _formRegistroKey = GlobalKey<FormState>();
  TextEditingController emailRegistroControl= new TextEditingController();
  TextEditingController userRegistroControl= new TextEditingController();
  TextEditingController passRegistroControl= new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children:[
          Center(
            child: Form(
            key: _formRegistroKey,
            child: Container(
              padding: EdgeInsets.only(top: 150.0),
                child: Card(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
              TextFormField(
                controller: userRegistroControl,
                autofocus: false,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person,),
                  hintText: 'Usuario',          
                ),
                validator: (String val){
                  if(val.isEmpty){
                    return "Ingrese un nombre de usuario";
                  }
                  return null;
                }
              ),
              TextFormField(
                controller: emailRegistroControl,
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
                controller: passRegistroControl,
                autofocus: false,
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock,),
                  hintText: 'Contraseña',          
                ),
                validator: (String val){
                  if(val.isEmpty){ //Si el campo está vacio...
                    return "Ingrese una contraseña";
                  }
                  return null;
                }
              ),
              SizedBox(height: 10.0),
              MaterialButton(
                onPressed:() async{
                  if(_formRegistroKey.currentState.validate()){
                    registrarUsuario();
                  }
                },  
                child: Text (
                  'Registrarse', 
                  style: GoogleFonts.varelaRound(fontSize: 18.0,color: Colors.lime),) 
              ),
              SizedBox(height: 10.0),
                      Center(child: Text("Luego de registrarse volverá al inicio de sesión para la verificación.",style: GoogleFonts.varelaRound(fontSize: 12.0,color: Colors.lime),)),
        ],
                  )
              
      )),
            ))),
              ] 
      ));
  }
void registrarUsuario() async{
  try{
    final User user = (await _auth.createUserWithEmailAndPassword(email: emailRegistroControl.text, password: passRegistroControl.text)).user; //Crea el usuario con email y contraseñña del formulario 
  if (user != null){
    if(!user.emailVerified){ //Si el usuario no está en la bd lo carga
      await user.sendEmailVerification();
    }
    await user.updateProfile(displayName: userRegistroControl.text); //Carga el nombre de usuario 
  }
  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
    return InicioSesion();
  }));  
  }catch(e){
    SnackBar(content: Text(e));
    print(e);
  }
  
}
}