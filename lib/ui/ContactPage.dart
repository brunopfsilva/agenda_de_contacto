import 'package:agenda_de_contactos/helpers/imports.dart';


class contactPage extends StatefulWidget {
  final Contact contact;

  //usar {} coloca o parametro como opcional
  contactPage({this.contact});

  @override
  _contactPageState createState() => _contactPageState();
}

class _contactPageState extends State<contactPage> {
  Contact _editcontact;
  bool _userEdit = false;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  final _nameFocus = FocusNode();

  @override
  void initState() {
    super.initState();

    if (widget.contact == null) {
      _editcontact = Contact();
    } else {
      _editcontact = Contact.fromMap(widget.contact.toMap());

      //pega o contacto do map e seta nos controladores
      _nameController.text = _editcontact.name;
      _emailController.text = _editcontact.email;
      _phoneController.text = _editcontact.phone;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _requestpop,
      child: Scaffold(
        appBar: AppBar(
          title: Text(_editcontact.name ?? "Novo Contacto"),
          centerTitle: true,
          backgroundColor: Colors.red,

        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (_editcontact.name != null && _editcontact.name.isNotEmpty) {
              //passando contacto para tela anterior
              Navigator.pop(context, _editcontact);
            } else {
              FocusScope.of(context).requestFocus(_nameFocus);
            }
          },
          child: Icon(Icons.save),
          backgroundColor: Colors.red,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              //para que o item seja clicavel adiona um filho ao gesturedetector
              GestureDetector(
                child: Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: _editcontact.img != null
                          ? FileImage(File(_editcontact.img))
                          : AssetImage("images/person.png"),
                    ),
                  ),
                ),
                onTap: () => ImagePicker.pickImage(source: ImageSource.camera).then((file){
                  if(file == null) return;
                  setState(() {
                    _editcontact.img = file.path;
                  });
                })
              ),
              TextField(
                decoration: InputDecoration(labelText: "Nome"),
                focusNode: _nameFocus,
                controller: _nameController,
                onChanged: (String text) {
                  _userEdit = true;
                  setState(() {
                    _editcontact.name = text;
                  });
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: "Email"),
                controller: _emailController,
                onChanged: (String text) {
                  _userEdit = true;
                  _editcontact.email = text;
                },
                keyboardType: TextInputType.emailAddress,
              ),
              TextField(
                decoration: InputDecoration(labelText: "Phone"),
                controller: _phoneController,
                onChanged: (String text) {
                  _userEdit = true;
                  _editcontact.phone = text;
                },
                keyboardType: TextInputType.phone,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _requestpop() {
    if (_userEdit) {
      showDialog(
          context: this.context,
          builder: (context) {
            return AlertDialog(
              title: Text("Descartar alterações?"),
              content: Text("Se sair as Alteraçºoes serão perdidas"),
              actions: <Widget>[
                FlatButton(
                  child: Text("Cancelar"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                FlatButton(
                  child: Text("Sim"),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          });
      //se o usuario modificou algo nao deixa sair da tela
      return Future.value(false);
    } else {
      //deixa sair da tela
      return Future.value(true);
    }
  }
}
