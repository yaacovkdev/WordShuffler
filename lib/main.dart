import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:quotelist/viewquotetemplate.dart';
import 'quote.dart';
import 'quotetemplate.dart';
import 'save.dart';

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



  List<Quote> quotes = [];

  Save save = new Save();
  bool viewMode = false;
  bool filesLoaded = false;
  bool saveInstance = false;

  final TextEditingController _textFieldController1 = TextEditingController();
  final TextEditingController _textFieldController2 = TextEditingController();
  String? valueText1, valueText2;
  Color cardcolor = Colors.white;

  Future<void> getFileQuotes() async {

    if(!filesLoaded) {
      String text = (await save.readFile());
      if(!text.isEmpty) {
        List<String> textList = text.split('\n');

        //Ugly List Notation
        List jsonObjects = textList.map((quote) => jsonDecode(quote)).toList();
        quotes = jsonObjects.map((jsonObjects) {
          Quote q = Quote(
              author: jsonObjects['author'], text: jsonObjects['text']);
          q.found = jsonObjects['found'];
          return q;
        }).toList();
      }

      //solution to cancel the blank screen at the app launch
      setState(() {
        filesLoaded = true;
      });
    } else if(saveInstance){
      await save.writeFile(quotes);
      saveInstance = false;
    }
  }

  makeValueNull(){
    valueText1 = null;
    valueText2 = null;
  }

  changeCardColor(Quote quote) {
    //this code gets run for EVERY card regardless if you clicked on it
    setState(() {
      if(quote.found) {
        cardcolor = Colors.white;
        quote.found = false;
      } else {
        cardcolor = Colors.orangeAccent;
        quote.found = true;
      }
      saveInstance = true;
    });
  }

  Color? colorOnEmpty(){
    Color? main = Colors.white;
    if(quotes.isEmpty){
      main = Colors.grey[300];
      return main;
    } else {
      main = Colors.blue[300];
      return main;
    }
  }

  Widget decideDisplay(){
    getFileQuotes();

    //mainView is literally an empty scrollable screen cause quotes are empty
    if(!filesLoaded){

      return mainView();
    }

    if (quotes.isEmpty){
      return tutorialDisplay();
    }
    return mainView();
  }

  Widget tutorialDisplay(){

    return Container(
      margin: EdgeInsets.all(50),

      child: const SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Instructions!',
              style: TextStyle(
                fontSize: 30,
                color: Colors.red,
              ),
            ),
            SizedBox(height: 15,),
            Text(
              '1. Press the Eye Button to switch between Edit and View Modes',
              style: TextStyle(
                fontSize: 30,
                color: Colors.red,
              ),
            ),
            SizedBox(height: 15,),
            Text(
              '2. Press the Shuffle Button to shuffle the card display order',
              style: TextStyle(
                fontSize: 30,
                color: Colors.red,
              ),
            ),
            SizedBox(height: 15,),
            Text(
              '3. Press the Plus Button to create new Word Card',
              style: TextStyle(
                fontSize: 30,
                color: Colors.red,
              ),
            ),
            SizedBox(height: 15,),
            Text(
              '4. Press and Hold on the Word Card to change Word and Author',
              style: TextStyle(
                fontSize: 30,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget mainView(){
    return Container(
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: quotes.map((quote) {

              if(quote.found){
                cardcolor = Colors.orangeAccent.withOpacity(0.5);
              } else {
                cardcolor = Colors.white;
              }

              if(viewMode) {
                return ViewQuoteCard(
                  quote: quote,
                  color: cardcolor,
                  changeColor: () => changeCardColor(quote),
                );
              }

              return EditQuoteCard(
                quote: quote,
                color: cardcolor,
                changeColor: () => changeCardColor(quote),
                delete: () {
                  setState(() {
                    quotes.remove(quote);
                    saveInstance = true;
                  });

                },
                changeText: () async {
                  await _displayTextInputDialog(context);
                  setState(() {

                    if(valueText1 != null) {quote.text = valueText1!;}
                    if(valueText2 != null) {quote.author = valueText2!;}
                    makeValueNull();
                    saveInstance = true;
                  });

                },
              );
            }).toList(),
          ),
        ),
      ),
    );
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
        title: Text('Empire Shuffler v0.1.2'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: decideDisplay(),

      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            backgroundColor: colorOnEmpty(),
            onPressed: () {
              if(quotes.isEmpty) return;
              setState(() {
                viewMode = !viewMode;
              });
            },
            child: const Icon(
              Icons.remove_red_eye_rounded,
              size: 40,
            ),
          ),
          SizedBox(height: 20,),
          FloatingActionButton(
            backgroundColor: colorOnEmpty(),
            onPressed: () {
              if(quotes.isEmpty) return;
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
                    text: valueText1 == null ? "" : valueText1!
                ));
                makeValueNull();
                saveInstance = true;
              });
            },
            child: const Icon(
              Icons.add,
              size: 40,
            ),
          ),
        ],
      ),
    );
  }
}


