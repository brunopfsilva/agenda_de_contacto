import 'package:agenda_de_contactos/helpers/imports.dart';

import 'ContactPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();

  ContactHelper helper = ContactHelper();

}

class _HomePageState extends State<HomePage> {
  List<Contact> contacts = List();

  @override
  void initState() {
    super.initState();

    //reinvio
    widget.helper.initDb();

    _getAllContacts();
  }

  void _getAllContacts() {

    widget.helper.getAllContcts().then((list) {
      setState(() {
        contacts = list;
      });
    });

  }

  Widget _cardontact(BuildContext context, int index) {
    return GestureDetector(
      child: Card(
        child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: <Widget>[
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      //se tiver imagem pega do ficheiro se nao pega a image padrao
                      image: contacts[index].img != null
                          ? FileImage(File(contacts[index].img))
                          : AssetImage("images/person.png"),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // se for vazio seta nome vazio
                      Text(
                        contacts[index].name ?? "",
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        contacts[index].email ?? "",
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                      Text(
                        contacts[index].phone ?? "",
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
      //Adicionar funcao abaixo do elemento que deseja que seja detectado pelo gesture detector
      onTap: () {
        _showContactPage(context, contact: contacts[index]);
      },
    );
  }

  void _showContactPage(BuildContext context, {Contact contact}) async {
    //passando contacto para outra pagina
    final contactoRecuperado = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => contactPage(contact: contact)));
    if (contactoRecuperado != null) {
        if(contact != null){
          await widget.helper.update(contactoRecuperado);
        }else {
          await widget.helper.saveContact(contactoRecuperado);
        }

        _getAllContacts();

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contactos"),
        backgroundColor: Colors.redAccent,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showContactPage(context);
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.redAccent,
      ),
      body: ListView.builder(
          padding: EdgeInsets.all(16.0),
          itemCount: contacts.length,
          itemBuilder: (context, index) {
            return _cardontact(context, index);
          }),
    );
  }




}



