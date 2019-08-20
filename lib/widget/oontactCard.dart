import 'package:agenda_de_contactos/helpers/imports.dart';


Widget _cardontact(BuildContext context, int index,List contacts) {
  return GestureDetector(
    onTap: () {

    },
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
              image: contacts[index].img),
        ),
      ),
      ],
    ),
  ),
  ),

  );

}