import 'package:flutter/material.dart';
import 'package:hr_app/models/personal_response.dart';
import 'package:hr_app/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:hr_app/services/personal_list_provider.dart';

class AddEditPersonalScreen extends StatefulWidget {
  const AddEditPersonalScreen({ Key? key }) : super(key: key);

  @override
  _AddEditPersonalScreenState createState() => _AddEditPersonalScreenState();
}

class _AddEditPersonalScreenState extends State<AddEditPersonalScreen> {
  GlobalKey<FormState> formKey = GlobalKey();
  String area = '';
  String nombre = '';
  String apellidoP = '';
  String apellidoM = '';
  String telefono = '';
  String fechNac = '';
  String email = '';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    //final personalProvider = Provider.of<PersonalListProvider>(context);
    PersonalResponse personal = ModalRoute.of(context)?.settings.arguments as PersonalResponse;
    
    final format = DateFormat("yyyy-MM-dd");
    /*personal = PersonalResponse(
      area: '', nombre: '', apellidoP: '', apellidoM: '', telefono: '', fech_nac: '', email: '',
    );*/

    return Scaffold(
      appBar: AppBar(
        title: Text(
         (personal.id == null) ? "Nuevo registro": "Editar registro"
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                TextFormField(
                  initialValue: (personal.area != "") ? personal.area:"",
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    labelText: "Área"
                  ),
                  validator: (value){
                    if(value == ""){
                      return "Campo requerido";
                    }
                  },
                  onChanged: (value){
                    area = value;
                  },
                  onSaved: (value){
                    area = value!;
                  },
                ),
                SizedBox(
                  height: size.height * 0.04,
                ),
                TextFormField(
                  initialValue: (personal.nombre != "") ? personal.nombre:"",
                  keyboardType: TextInputType.name,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    labelText: "Nombre"
                  ),
                  onChanged: (value){
                    nombre = value;
                  },
                  validator: (value){
                    if(value!.isEmpty){
                      return "Campo requerido";
                    }
                  },
                  onSaved: (value){
                    nombre = value!;
                  },
                ),
                SizedBox(
                  height: size.height * 0.04,
                ),
                TextFormField(
                  initialValue: (personal.apellidoP != "")?personal.apellidoP:"",
                  keyboardType: TextInputType.name,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    labelText: "Apellido Paterno"
                  ),
                  onChanged: (value){
                    apellidoP = value;
                  },
                  validator: (value){
                    if(value!.isEmpty){
                      return "Campo requerido";
                    }
                  },
                  onSaved: (value){
                    apellidoP = value!;
                  },
                ),
                SizedBox(
                  height: size.height * 0.04,
                ),
                TextFormField(
                  initialValue: (personal.apellidoM != "")?personal.apellidoM:"",
                  keyboardType: TextInputType.name,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    labelText: "Apellido Materno"
                  ),
                  onChanged: (value){
                    apellidoM = value;
                  },
                  validator: (value){
                    if(value!.isEmpty){
                      return "Campo requerido";
                    }
                  },
                  onSaved: (value){
                    apellidoM = value!;
                  },
                ),
                SizedBox(
                  height: size.height * 0.04,
                ),
                TextFormField(
                  initialValue: (personal.telefono != "")?personal.telefono:"",
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: "Teléfono"
                  ),
                  onChanged: (value){
                    telefono = value;
                  },
                  validator: (value){
                    if(value!.isEmpty){
                      return "Campo requerido";
                    }
                  },
                  onSaved: (value){
                    telefono = value!;
                  },
                ),
                SizedBox(
                  height: size.height * 0.04,
                ),
                DateTimeField(
                  initialValue: (personal.fech_nac != "")?DateTime.parse(personal.fech_nac):null,
                  format: format,
                  decoration: InputDecoration(
                    labelText: "Fecha de nacimiento"
                  ),
                  onChanged: (fecha){
                    print(fecha);
                    fechNac = fecha.toString();
                  },
                  validator: (fecha){
                    if(fecha == null){
                      return "Campo requerido";
                    }
                  },
                  onSaved: (fecha){
                    fechNac = fecha.toString();
                  },
                  onShowPicker: (context, currentValue){
                    return showDatePicker(
                      context: context, 
                      initialDate: currentValue ?? DateTime.now(), 
                      firstDate: DateTime(1900), 
                      lastDate: DateTime(2100)
                    );
                  }
                ),
                /*TextFormField(
                  keyboardType: TextInputType.datetime,
                  decoration: InputDecoration(
                    labelText: "Fecha de nacimiento"
                  ),
                  onChanged: (value){

                  },
                  onSaved: (value){

                  },
                ),*/
                SizedBox(
                  height: size.height * 0.04,
                ),
                TextFormField(
                  initialValue: (personal.email != "")?personal.email:"",
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "Correo electrónico"
                  ),
                  onChanged: (value){
                    email = value;
                  },
                  validator: (value){
                    if(value!.isEmpty){
                      return "Campo requerido";
                    }
                  },
                  onSaved: (value){
                    email = value!;
                  },
                ),
                SizedBox(
                  height: size.height * 0.04,
                ),
                Container(
                  width: size.width * 0.6,
                  height: size.height * 0.05,
                  child: ElevatedButton(
                    child: Text("Guardar"),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.indigo
                    ),
                    onPressed: ()async{
                     final personalProvider = Provider.of<PersonalListProvider>(context, listen: false);
                     if(formKey.currentState!.validate()){
                        formKey.currentState!.save();
                        if(personal.id == null){
                          final id = await personalProvider.nuevoPersonal(
                            area, 
                            nombre, 
                            apellidoP, 
                            apellidoM, 
                            telefono, 
                            fechNac, 
                            email
                          );

                          if(id > 0){
                            mostrarConfirmar(context, "Personal registrado");
                          }
                        }else{
                          personal.area = area;
                          personal.nombre = nombre;
                          personal.apellidoP = apellidoP;
                          personal.apellidoM = apellidoM;
                          personal.telefono = telefono;
                          personal.fech_nac = fechNac;
                          personal.email = email;
                          final id = await personalProvider.updatePersonal(
                            personal.id!, 
                            personal.area,
                            personal.nombre,
                            personal.apellidoP,
                            personal.apellidoM,
                            personal.telefono,
                            personal.fech_nac,
                            personal.email
                          );

                          if(id > 0){
                            mostrarConfirmar(context, "Personal actualizado");
                          }
                        }
                     }
                      
                    }
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}