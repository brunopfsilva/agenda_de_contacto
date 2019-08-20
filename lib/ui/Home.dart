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



    ContactHelper helper = ContactHelper();
    helper.initDb();

    helper.getAllContcts().then((list){

      setState(() {
        contacts = list;
      });

    });

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
      floatingActionButton: FloatingActionButton(onPressed: (){ },
      child: Icon(Icons.add) ,
        backgroundColor: Colors.redAccent,
      ),
      body: ListView.builder(
          padding: EdgeInsets.all(16.0),
          itemCount: contacts.length,
          itemBuilder: (context,index){

          }
          ),
    );
  }
}
