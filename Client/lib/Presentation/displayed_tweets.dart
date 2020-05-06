import 'package:expert_system/Models/tweet.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

//La segunda Pantalla despliega los tweets que se encontraron.
class DisplayedTweets extends StatelessWidget {
  final List<Tweet> tweetstoDisplay;

  DisplayedTweets({Key key, @required this.tweetstoDisplay}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),

      body: Container( 
      decoration: BoxDecoration(
                gradient: //El fondo es decorado con un gradiente lineal.
                LinearGradient(colors: [Colors.blue[800], Colors.blue[400]])),
    
      child: Center(

        
          //La clase List View se utiliza para generar una lista de Widgets dinàmica.
          child: new ListView.builder(
              itemCount: tweetstoDisplay.length,
              itemBuilder: (BuildContext ctxt, int index) {
                //ctxt contexto. índice.
                return new Text(
                  
                  tweetstoDisplay[index].fullText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontFamily: 'Roboto Light',
                    fontWeight: FontWeight.normal,
                    height: 3,
                    letterSpacing: 1.0
                   
                  ),
                );
              })),
    ));
  }
}
