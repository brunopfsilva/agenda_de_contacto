import 'package:agenda_de_contactos/helpers/imports.dart';

enum OderOptions { oderaz, orderza }

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

    setState(() {
      _getAllContacts();
    });
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
                  width: MediaQuery.of(context).size.width/2,
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
        _showOptions(context, index);
      },
    );
  }

  void _showContactPage(BuildContext context, {Contact contact}) async {
    //passando contacto para outra pagina
    final contactoRecuperado = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => contactPage(contact: contact)));
    if (contactoRecuperado != null) {
      if (contact != null) {
        await widget.helper.update(contactoRecuperado);
      } else {
        await widget.helper.saveContact(contactoRecuperado);
      }

      _getAllContacts();
    }
  }

  void _showOptions(BuildContext context, int index) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return BottomSheet(
            onClosing: () {},
            builder: (context) {
              return Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  //ocupa o menor espaço possivel na coluna principal
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: FlatButton(
                        child: Text(
                          "Ligar",
                          style: TextStyle(color: Colors.red, fontSize: 20.0),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          launch("tel:${contacts[index].phone}");
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: FlatButton(
                        child: Text(
                          "Editar",
                          style: TextStyle(color: Colors.red, fontSize: 20.0),
                        ),
                        onPressed: () {
                          // fecha o menu
                          Navigator.pop(context);
                          _showContactPage(context, contact: contacts[index]);
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: FlatButton(
                        child: Text(
                          "Excluir",
                          style: TextStyle(color: Colors.red, fontSize: 20.0),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          setState(() {
                            widget.helper.deleteContact(contacts[index].id);
                            contacts.removeAt(index);
                          });
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    var mediaqery = MediaQuery.of(context);
    var size = mediaqery.size;

    return Scaffold(
      appBar: AppBar(
        title: Text("Contactos"),
        backgroundColor: Colors.redAccent,
        centerTitle: true,
        actions: <Widget>[
          PopupMenuButton<OderOptions>(
            itemBuilder: (BuildContext context) =>
            <PopupMenuEntry<OderOptions>>[
              const PopupMenuItem<OderOptions>(
                value: OderOptions.oderaz,
                child: Text('Ordenar A-Z'),
              ),
              const PopupMenuItem<OderOptions>(
                value: OderOptions.orderza,
                child: Text('Ordenar Z-A'),
              ),
            ],
            onSelected: _orderList,
          )
        ],
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showContactPage(context);
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.redAccent,
      ),
      body: Container(
        width: size.width/2,
        child: ListView.builder(
          padding: EdgeInsets.all(16.0),
          itemCount: contacts.length,
          itemBuilder: (context, index) {
            return _cardontact(context, index);
          },),
      ),
    );
  }

  void _orderList(OderOptions value) {
    switch (value) {
      case OderOptions.orderza:
        contacts.sort((a, b) {
          return a.name.toLowerCase().compareTo(b.name.toLowerCase());
        });
        break;
      case OderOptions.orderza:
        contacts.sort((a, b) {
          return b.name.toLowerCase().compareTo(a.name.toLowerCase());
        });
        break;

      default:
        break;
    }
    setState(() {});
  }
}
