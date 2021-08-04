import 'package:flutter/cupertino.dart';
import 'package:hr_app/models/personal_response.dart';
import 'package:hr_app/services/db_provider.dart';

class PersonalListProvider extends ChangeNotifier{
  List<PersonalResponse> personales = [];

  Future<int>nuevoPersonal(String area, String nombre, String apeP, String apeM, String telefono, String fechNac, String email)async{
    final nuevoPersonal = PersonalResponse(
      area: area,
      nombre: nombre,
      apellidoP: apeP,
      apellidoM: apeM,
      telefono: telefono,
      fech_nac: fechNac,
      email: email
    );

    final id = await DBProvider.db.nuevoPersonal(nuevoPersonal);
    // Asignar el id de la base de datos al modelo
    nuevoPersonal.id = id;
    this.personales.add(nuevoPersonal);
    notifyListeners();
    return id;
  }

  Future<int>updatePersonal(int id, String area, String nombre, String apeP, String apeM, String telefono, String fechNac, String email)async{
    final updatePersonal = PersonalResponse(
      id: id,
      area: area, 
      nombre: nombre, 
      apellidoP: apeP, 
      apellidoM: apeM, 
      telefono: telefono, 
      fech_nac: fechNac, 
      email: email
    );
    final res = await DBProvider.db.updatePersonal(updatePersonal);
    //updatePersonal.id = id;
    final index = this.personales.indexWhere((element) => element.id == updatePersonal.id);
    this.personales[index] = updatePersonal;
    this.cargarPersonalId(id);
    notifyListeners();
    return res;
  }

  cargarPersonales()async{
    final personales = await DBProvider.db.getTodosPersonal();
    this.personales = [...personales];
    notifyListeners();
  }

  cargarPersonalId(int id)async{
    final personal = await DBProvider.db.getPersonalById(id);
    return personal;
  }

  borrarTodos()async{
    await DBProvider.db.deleteAllPersonals();
    this.personales = [];
    notifyListeners();
  }

  borrarPersonalById(int id)async{
    await DBProvider.db.deletePersonal(id);
    this.cargarPersonales();
  }
}