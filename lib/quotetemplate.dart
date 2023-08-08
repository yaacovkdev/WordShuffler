import 'package:flutter/material.dart';
import 'quote.dart';

class QuoteCard extends StatelessWidget {

  final Quote quote;
  Color color = Colors.white;
  final Function() delete;
  final Function() changeText;
  final Function() changeColor;

  QuoteCard({required this.quote, required this.delete, required this.changeText, required this.changeColor, required this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: changeText,
      onTap: changeColor,
      child: Card(
        color: color,
        margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(

              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,

              children: <Widget>[
                Text(
                  quote.text,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey[800],

                  ),
                ),
                SizedBox(height: 10),
                Text(
                  '- ${quote.author}',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey[800],

                  ),
                ),
                SizedBox(height: 8,),
                TextButton.icon(
                    onPressed: delete,
                    label: Text("Delete"),
                    icon: Icon(Icons.delete),
                ),
                /*TextButton.icon(
                onPressed: () {},
                child: Icon(

                )
              ),*/
              ]
          ),
        ),
      ),
    );
  }


}