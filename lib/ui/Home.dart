import 'package:agenda_de_contactos/helpers/imports.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  ContactHelper helper = ContactHelper();

  @override
  void initState() {

    super.initState();


    Contact c = new Contact();


    c.name = "Bruno silva";
    c.email = "bruno.pfsilva@hotmail.com";
    c.phone = "915031601";
    c.img = "img";

    helper.saveContact(c);


    helper.getAllContcts().then((list){print(list);});

  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
