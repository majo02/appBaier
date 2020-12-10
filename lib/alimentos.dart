import 'package:http/http.dart' as http; //Paquete para usar http
import 'dart:convert'; //Paquete de dart

class Alimento{ 
  String nombre;
  String porcion;
  String id;
  String carbos;
  String proteinas;
  String grasas;

  bool presionado = false;
  String urlImg;
  void cambiarFav() {
    if (presionado) {
      presionado = false;
    } else {
      presionado = true;
    }
    print(presionado);
  }
  
  Alimento({this.id ,this.nombre, this.urlImg, this.porcion, this.carbos, this.proteinas, this.grasas, this.presionado}); //Constructor

}
List<Alimento> _alimentos = [];
void addAlimento(String nombre, String porcion, String carbos, String proteinas, String grasas, String url){ 
  Map<String, dynamic> datosAlimentos ={  
    'nombre': nombre,
    'porcion': porcion,
    'carbos': carbos,
    'proteinas': proteinas,
    'grasas': grasas,
    'url': url,
  };
  http.post('https://biblioteca-f5d65.firebaseio.com/alimentos.json', body: json.encode(datosAlimentos)).then((http.Response respuesta){
   Map<String, dynamic> datosRespuesta = json.decode(respuesta.body);
   Alimento newAlimento = Alimento( 
    id: datosRespuesta['name'],
    nombre: nombre,
    porcion: porcion,
    carbos: carbos,
    proteinas: proteinas,
    grasas: grasas,
  );
  _alimentos.add(newAlimento); 
  }
  );
}


void addAlimentoFav(Alimento alimento){
  final Map<String, dynamic> datosAlimentos ={ 
    'id': alimento.id,
    'nombre': alimento.nombre,
    'porcion': alimento.porcion,
    'carbos': alimento.carbos,
    'proteinas': alimento.proteinas,
    'grasas': alimento.grasas,
    'url': alimento.urlImg,
  };
  http.post('https://biblioteca-f5d65.firebaseio.com/favoritos.json', body: json.encode(datosAlimentos)).then((http.Response respuesta){
  final Map<String, dynamic> datosRespuesta = json.decode(respuesta.body);  
  final Alimento newAlimento = Alimento(
    id: datosRespuesta['name'],
    nombre: alimento.nombre,
  );
   _alimentos.add(newAlimento);
  }
  );
}

void addAlimentoBuscado(Alimento alimento){
  final Map<String, dynamic> datosAlimentos ={ 
    'nombre': alimento.nombre,
    'porcion': alimento.porcion,
    'carbos': alimento.carbos,
    'proteinas': alimento.proteinas,
    'grasas': alimento.grasas,
  };
  http.post('https://biblioteca-f5d65.firebaseio.com/buscados.json', body: json.encode(datosAlimentos)).then((http.Response respuesta){
  final Map<String, dynamic> datosRespuesta = json.decode(respuesta.body);  
  final Alimento newAlimento = Alimento(
    id: datosRespuesta['name'],
    nombre: alimento.nombre,
    porcion: alimento.porcion,
    carbos: alimento.carbos,
    proteinas: alimento.proteinas,
    grasas: alimento.grasas,
  );
  _alimentos.add(newAlimento); 
  }
  );
}
void borrarAlimentoFav(String id) { 
 String idAlimento = id;
 http.delete('https://biblioteca-f5d65.firebaseio.com/favoritos/$idAlimento.json');
  }

void borrarAlimentoBd(String id) { 
 String idAlimento = id;
 http.delete('https://biblioteca-f5d65.firebaseio.com/alimentos/$idAlimento.json'); 
}