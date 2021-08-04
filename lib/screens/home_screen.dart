import 'package:flutter/material.dart';
import 'package:hr_app/models/personal_response.dart';
import 'package:hr_app/services/personal_list_provider.dart';
import 'package:hr_app/utils/utils.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    //Usar el PersonalListProvider
    final personalProvider = Provider.of<PersonalListProvider>(context);

    personalProvider.cargarPersonales();
    final personales = personalProvider.personales;
    PersonalResponse personalResponse = PersonalResponse(area: '', nombre: '', apellidoP: '', apellidoM: '', fech_nac: '', telefono: '', email: ''
);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "RH App"
        ),
      ),
      body: (personales.length == 0) ?
        Center(
          child: Text(
            "La lista está vacía"
          ),
        ):
        ListView.builder(
        itemCount: personales.length,
        itemBuilder: (BuildContext context, int i){
          return ListTile(
            leading: Icon(
              Icons.person,
              color: Theme.of(context).primaryColor,
            ),
            title: Text(
              "${personales[i].nombre}"
            ),
            subtitle: Text(
              "${personales[i].area}"
            ),
            trailing: Container(
              width: size.width * 0.2,
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: (){
                      mostrarAlerta(
                        context, 
                        (){
                          Provider.of<PersonalListProvider>(context, listen: false).borrarPersonalById(personales[i].id!);
                          Navigator.pop(context);
                        }
                      );
                    }
                  ),
                  Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
            onTap: (){
              Navigator.pushNamed(context, 'add', arguments: personales[i]);
            },
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
        ),
        backgroundColor: Colors.indigo,
        onPressed: (){
          Navigator.pushNamed(context, 'add', arguments: personalResponse);
        },
      ),
    );
  }
}