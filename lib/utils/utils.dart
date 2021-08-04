import 'package:flutter/material.dart';

void mostrarAlerta(BuildContext context, VoidCallback? onPressed){
  showDialog(
    context: context, 
    builder: (context){
      return AlertDialog(
        title: Text("Confirmar eliminar"),
        content: Text("¿Seguro que quieres eliminarlo?"),
        actions: [
          TextButton(
            child: Text("Si"),
            onPressed: onPressed
          ),
          TextButton(
            child: Text("No"),
            onPressed: (){
              Navigator.pop(context);
            }
          )
        ],
      );
    }
  );
}

void mostrarConfirmar(BuildContext context, String texto){
  showDialog(
    context: context, 
    builder: (context){
      return AlertDialog(
        title: Text("Mensaje de confirmación"),
        content: Text(texto),
        actions: [
          TextButton(
            child: Text("Aceptar"),
            onPressed: (){
              Navigator.pop(context);
            }
          ),
        ],
      );
    }
  );
}