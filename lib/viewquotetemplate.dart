import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quotelist/quote.dart';

class ViewQuoteCard extends StatelessWidget {

  final Quote quote;
  Color color = Colors.white;
  final Function() changeColor;

  ViewQuoteCard({required this.quote, required this.color, required this.changeColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: changeColor,
      child: Card(
        margin: EdgeInsets.fromLTRB(16, 20, 16, 0),
        color: color,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                quote.text,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey[800],

                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
