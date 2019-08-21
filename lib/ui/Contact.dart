import 'package:agenda_de_contactos/helpers/imports.dart';

class contactPage extends StatefulWidget {

  final Contact contact;

  //usar {} coloca o parametro como opcional
  contactPage({this.contact});

  @override
  _contactPageState createState() => _contactPageState();



}



class _contactPageState extends State<contactPage> {

  Contact editcontact;

  @override
  void initState() {
    super.initState();

    if(widget.contact == null){



    }

  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
