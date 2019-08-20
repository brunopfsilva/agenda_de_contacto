import 'package:agenda_de_contactos/helpers/imports.dart';


class HomePage extends StatefulWidget {


  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Contact>contacts = List();

  @override
  void initState() {
    super.initState();

    //reinvio
    ContactHelper helper = ContactHelper();
    helper.initDb();

    helper.getAllContcts().then((list) {
      setState(() {
        contacts = list;
      });
    });
  }

  Widget _cardontact(BuildContext context, int index) {
    return GestureDetector(
        child: Card(
          child: Padding(padding: EdgeInsets.all(16.0),
            child: Row(
            children: <Widget>[
            Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(

                //se tiver imagem pega do ficheiro se nao pega a image padrao
                image: contacts[index].img != null ?
                FileImage(File(contacts[index].img)) :
                AssetImage("images/person.png"),

              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // se for vazio seta nome vazio
                Text(contacts[index].name ?? "",style: TextStyle(fontSize: 20.0,
                    fontWeight: FontWeight.bold),
                ),
                Text(contacts[index].email ?? "",style: TextStyle(fontSize: 20.0,),
                ),
                Text(contacts[index].phone ?? "",style: TextStyle(fontSize: 20.0,
                    fontWeight: FontWeight.bold),
                ),
                ],
            ),

          ),
          ],

        )
    ),

    )
    ,

    );

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
      floatingActionButton: FloatingActionButton(onPressed: () {},
        child: Icon(Icons.add),
        backgroundColor: Colors.redAccent,
      ),
      body: ListView.builder(
          padding: EdgeInsets.all(16.0),
          itemCount: contacts.length,
          itemBuilder: (context, index) {
            return _cardontact(context, index);
          }
      ),
    );
  }
}
