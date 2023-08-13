import 'package:flutter/material.dart';
import 'quote.dart';

class EditQuoteCard extends StatelessWidget {

  final Quote quote;
  Color color = Colors.white;
  final Function() delete;
  final Function() changeText;
  final Function() changeColor;

  EditQuoteCard({required this.quote, required this.color, required this.changeColor, required this.delete, required this.changeText});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(

      onLongPress: changeText,
      onTap: changeColor,
      child: Card(
        margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
        shape: RoundedRectangleBorder(
          side: BorderSide(
          color: color,
          width: 1,
          ),
        ),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          quote.text,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey[800],

                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '- ${quote.author}',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey[800],

                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),

                  Expanded(
                    flex: 2,
                    child: TextButton.icon(
                      onPressed: delete,
                      label: Text("Delete"),
                      icon: Icon(Icons.delete),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}