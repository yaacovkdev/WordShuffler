import 'package:flutter/material.dart';
import 'quote.dart';

class QuoteCard extends StatelessWidget {

  final Quote quote;
  Color color = Colors.white;
  final Function() delete;
  final Function() changeText;
  final Function() changeColor;
  final Column textColumn;
  final Expanded deleteExpanded;

  QuoteCard({required this.quote, required this.delete, required this.changeText, required this.changeColor, required this.color, required this.textColumn, required this.deleteExpanded});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(

      onLongPress: changeText,
      onTap: changeColor,
      child: Card(
        color: color,
        margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(

                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,

                  children: <Widget>[
                    Row(



                      children: <Widget>[
                        Expanded(
                          flex: 5,

                          child: textColumn,
                        ),
                        SizedBox(width: 20),

                        deleteExpanded,


                      ],

                    ),

                    /*TextButton.icon(
                    onPressed: () {},
                    child: Icon(

                    )
                  ),*/
                  ],
              ),
        ),
      ),
    );
  }


}