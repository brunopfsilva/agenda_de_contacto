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
    return Scaffold(
      appBar: AppBar(
        title: Text(_editcontact.name ?? "Novo Contacto"),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
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
            ),
            TextField(
              decoration: InputDecoration(labelText: "Nome"),
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
    );
  }
}
