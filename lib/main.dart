

import 'package:flutter/material.dart';
import 'quote.dart';
import 'quotetemplate.dart';

void main() {
  runApp(MaterialApp(
    home: QuoteHome(),
  ));
}

class QuoteHome extends StatefulWidget {

  @override
  State<QuoteHome> createState() => _QuoteHomeState();
}

class _QuoteHomeState extends State<QuoteHome> {
  List<Quote> quotes = [
    Quote(author: 'Yasha', text: 'Hold Me'),
  ];

  final TextEditingController _textFieldController1 = TextEditingController();
  final TextEditingController _textFieldController2 = TextEditingController();
  String? valueText1, valueText2;
  Color cardcolor = Colors.white;

  makeValueNull(){
    valueText1 = null;
    valueText2 = null;
  }

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Quote Menu'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  onChanged: (value1) {
                    setState(() {
                      valueText1 = value1;
                    });
                  },
                  controller: _textFieldController1,
                  decoration: InputDecoration(hintText: "Word"),
                ),
                TextField(
                  onChanged: (value2) {
                    setState(() {
                      valueText2 = value2;
                    });
                  },
                  controller: _textFieldController2,
                  decoration: InputDecoration(hintText: "Author"),
                ),
              ],
            ),


            actions: <Widget>[
              MaterialButton(
                color: Colors.green,
                textColor: Colors.white,
                child: Text('OK'),
                onPressed: () {
                  setState(() {
                    _textFieldController1.text = "";
                    _textFieldController2.text = "";
                    Navigator.pop(context);
                  });
                },
              ),
            ],
          );
        });
  }




  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('Empire Shuffler v0.0.3'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            
            children: quotes.map((quote) {
              return QuoteCard(
                color: quote.found == false ? Colors.white : Colors.orangeAccent,
                quote: quote,
                delete: () {
                  setState(() {
                    quotes.remove(quote);
                  });
                },
                changeText: () async {
                  await _displayTextInputDialog(context);
                  setState(() {

                    if(valueText1 != null) {quote.text = valueText1!;}
                    if(valueText2 != null) {quote.author = valueText2!;}
                    makeValueNull();

                  });
                },
                changeColor: () {
                  //this code gets run for EVERY card regardless if you clicked on it
                  setState(() {
                    if(quote.found) {
                      cardcolor = Colors.white;
                      quote.found = false;
                    } else {
                      cardcolor = Colors.orangeAccent;
                      quote.found = true;
                    }
                  });
                },
              );
            }).toList(),
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            backgroundColor: Colors.blue[300],
            onPressed: () {
              setState(() {
                quotes.shuffle();
              });
            },
            child: const Icon(
              Icons.shuffle,
              size: 40,
            ),
          ),
          SizedBox(height: 20,),
          FloatingActionButton(
            backgroundColor: Colors.blue[300],


            onPressed: () async {
              await _displayTextInputDialog(context);
              setState(() {
                quotes.add(Quote(
                    author: valueText2 == null ? "Anonymous" : valueText2!,
                    text: valueText1 == null ? "" : valueText1!),
                );
                makeValueNull();
              });
            },
            child: const Icon(
              Icons.add,
              size: 40,
            ),
          ),
          SizedBox(height: 20,),
          FloatingActionButton(
            backgroundColor: Colors.blue[300],
            onPressed: () {
              setState(() {
                quotes.clear();
              });
            },
            child: const Icon(
              Icons.delete_forever,
              size: 40,
            ),
          ),
        ],
      ),
    );
  }
}


