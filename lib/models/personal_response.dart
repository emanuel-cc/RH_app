// To parse this JSON data, do
//
//     final personalResponse = personalResponseFromMap(jsonString);

import 'dart:convert';

class PersonalResponse {
    PersonalResponse({
      this.id,
      required this.area,
      required this.nombre,
      required this.apellidoP,
      required this.apellidoM,
      required this.telefono,
      required this.fech_nac,
      required this.email,
    });

    int? id;
    String area;
    String nombre;
    String apellidoP;
    String apellidoM;
    String telefono;
    String fech_nac;
    String email;

    factory PersonalResponse.fromJson(String str) => PersonalResponse.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory PersonalResponse.fromMap(Map<String, dynamic> json) => PersonalResponse(
        id: json["id"],
        area: json["area"],
        nombre: json["nombre"],
        apellidoP: json["apellido_p"],
        apellidoM: json["apellido_m"],
        telefono: json["telefono"],
        fech_nac: json["fech_nac"],
        email: json["email"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "area": area,
        "nombre": nombre,
        "apellido_p": apellidoP,
        "apellido_m": apellidoM,
        "telefono": telefono,
        "fech_nac": fech_nac,
        "email": email,
    };
}
