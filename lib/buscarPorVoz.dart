//import 'package:appbaier2/pagBuscadosVoz.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BuscarPorVoz extends StatefulWidget{
  @override 
  _BuscarPorVozState createState()=> _BuscarPorVozState();
}

class _BuscarPorVozState extends State<BuscarPorVoz>{
  stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = "Toque el boton para buscar";
  @override
  void initState() {
    super.initState();
    _speech= stt.SpeechToText();
  }
  @override 
  Widget build(BuildContext context) {
    return Scaffold( 
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
          animate: _isListening,
          glowColor: Colors.lime,
          endRadius: 75.0,
          duration: const Duration(milliseconds: 2000),
          repeatPauseDuration: const Duration(milliseconds: 100),
          repeat: true,
          child: FloatingActionButton(
            backgroundColor: Colors.lime,
            onPressed: ()=> _listen(),
            child: Icon(_isListening ? Icons.mic : Icons.mic_none)
          ),),

      body: SingleChildScrollView( 
      reverse: true,
      padding: EdgeInsets.all(80), //Posición
        child: Text(_text, style: GoogleFonts.varelaRound(fontSize: 20.0, color: Colors.lime)),
       ));
  }
  void _listen() async{
  if (!_isListening){
    print('si');
    bool available = await _speech.initialize( //Para inicializar el speech
      onStatus: (val)=> print('onStatus: $val'),
      onError: (val)=> print('onError: $val'),
    );
    if (available){
      setState(()=> _isListening = true); 
      _speech.listen( //Para que se empiece a escuchar
        onResult: (val) => setState((){ //Se activa cada vez que se escuchan nuevas palabras
          _text = val.recognizedWords;
          /*Navigator.push( 
                    context,
                    MaterialPageRoute(builder: (context) => PantallaBuscadosVoz(alimentoAmostrarNombre: _text))); //Clase con los alimentos*/
          
        }),
      );
    }
  }else{
    setState(()=> _isListening = false);
    _speech.stop();
  }
}
}

