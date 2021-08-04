import 'dart:io';
import 'package:hr_app/models/personal_response.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider{
  static Database? _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database>get database async{
    if(_database != null){
      return _database!;
    }
    _database = await initDB();
    return _database!;
  }

  Future<Database> initDB()async{
    // Path donde almacenaremos la base de datos
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'RHDB.db');

    print(path);
    // Crear base de datos
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db){},
      onCreate: (Database db, int version)async{
        await db.execute('''
          CREATE TABLE Personales(
            id INTEGER PRIMARY KEY,
            area TEXT,
            nombre TEXT,
            apellido_p TEXT,
            apellido_m TEXT,
            telefono TEXT,
            fech_nac TEXT,
            email TEXT
          )
        
        ''');
      }
    );
  }

  Future<int>nuevoPersonalRaw(PersonalResponse personal)async{
    final id = personal.id;
    final area = personal.area;
    final nombre = personal.nombre;
    final apellidoP = personal.apellidoP;
    final apellidoM = personal.apellidoM;
    final telefono = personal.telefono;
    final fechNac = personal.fech_nac;
    final email = personal.email;

    // Verificar la base de datos
    final db = await database;
    final res = db.rawInsert('''
      INSERT INTO Personales(id, area, nombre, apellido_p, apellido_m, telefono, fech_nac, email)
      VALUES( '$id', '$area', '$nombre', '$apellidoP', '$apellidoM', '$telefono', '$fechNac', '$email' )
    
    ''');

    return res;
  }

  Future<int> nuevoPersonal(PersonalResponse personal)async{
    final db = await database;
    final res = await db.insert('Personales', personal.toMap());

    // Es el ID del ultimo registro insertado
    return res;
  }

  Future<PersonalResponse>getPersonalById(int id)async{
    final db = await database;
    final List<Map<String, dynamic>> res = await db.query('Personales', where: 'id = ?', whereArgs: [id]);

    return PersonalResponse.fromMap(res.first);
  }

  Future<List<PersonalResponse>>getTodosPersonal()async{
    final db = await database;
    final List<Map<String, dynamic>> res = await db.query('Personales');

    return (res.isNotEmpty) ? res.map((p) => PersonalResponse.fromMap(p)).toList() : [];
  }

  /*Future<List<PersonalResponse>>getTodosPersonal()async{
    final db = await database;
    final List<Map<String, dynamic>> res = await db.query('Personales');

    return (res.isNotEmpty) ? res.map((p) => PersonalResponse.fromMap(p)).toList() : [];
  }*/

  Future<int> updatePersonal(PersonalResponse personal)async{
    final db = await database;
    final res = await db.update('Personales', personal.toMap(), where: 'id = ?', whereArgs: [personal.id]);

    return res;
  }

  Future<int> deletePersonal(int id)async{
    final db = await database;
    final res = await db.delete('Personales', where: 'id=?', whereArgs: [id]);
    return res;
  }

  Future<int> deleteAllPersonals()async{
    final db = await database;
    final res = await db.delete('Personales');
    return res;
  }

  Future<int> deleteAllPersonalsRaw()async{
    final db = await database;
    final res = await db.rawDelete('''
      DELETE FROM Personales
    
    ''');
    return res;
  }
}