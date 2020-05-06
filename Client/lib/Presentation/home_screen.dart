import 'package:expert_system/Presentation/displayed_tweets.dart';
import 'package:expert_system/Services/tweet_fetch_service.dart';
import 'package:flutter/material.dart';

class MyApplication extends StatelessWidget {   //Se crea un Widget que contiene un Widget de Formulario.
    @override
    Widget build(BuildContext context) {
      return new MaterialApp
        (
          home: new MyCustomForm()
      );
    }
  }

  class MyCustomForm extends StatefulWidget { // Widget de Formulario personalizado es creado.
    /*El widget funciona como un contenedor para uno o diversos campos a llenar en el formulario.*/

    @override
    MyCustomFormState createState() {
      return MyCustomFormState();
    }
  }

  class MyCustomFormState extends State<MyCustomForm> { //El

    final globalKey = GlobalKey<ScaffoldState>();


    final _formKey = GlobalKey<FormState>(); /*Se proporciona una llave global o Global Key con la finalidad de identificar
    //de manera única el Widget de formulario. Permitirá validar el Formulario en una serie de pasos*/
    final myController = TextEditingController();/*Se crea un controlador de texto con la finalidad de guardar un valor ingresado en un formulario*/
    //bool saved = false;
    //String _Username;

    @override
    void dispose() {
      //
      myController.dispose();
      super.dispose();
    }

    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        title: 'Flutter Gradients',
        home: Scaffold(

          key: globalKey,
          //appBar: AppBar(
          //title: Text('TwitterTracker',
          //style: TextStyle(fontFamily:  'Text Me One')),
          //),
          body: Container( /*El cuerpo de la aplicación está constituido de un Widget de tipo contenedor principal que a su vez
          contiene otros Widgets. */
            decoration: BoxDecoration(
                gradient: //El fondo es decorado con un gradiente lineal.
                LinearGradient(colors: [Colors.blue[800], Colors.blue[400]])),
            child: Center( //El Widget de tipo Center permite centrar otros Widgets y/o elementos en el centro de la pantalla.
                child: Container(
                  width: 350,
                  child: Wrap(
                    //Wrap es un Widget que permite alinear los elementos que están dentro de él.
                      spacing: 20,
                      runSpacing: 40,
                      //mainAxisAlignment: MainAxisAlignment.center,
                      //Los elementos en un Widget de tipo Wrap se enlista dentro de un arreglo llamado children o "hijos".
                      children: <Widget>[ 

                        Form( //El Widget de tipo Form contiene el formulario.

                          key: _formKey,
                          //Existe otro Widget de tipo Wrap dentro del formulario para la optimización de espacio entre elementos.
                          child: Wrap( 

                            spacing: 20, //Espacios entre elementos
                          runSpacing: 40,
                          //Los hijos del Widget Wrap serán los elementos que formarán parte del Formulario.

                          children: <Widget>[ 
                            /* El primer elemento del formulario es un campo de texto de formulario donde el usuario tecleará
                              el nombre de usuario de Twitter que desea buscar*/
                            TextFormField(

                              //El elemento que permitirá guardar los datos tecleados dentro de el contexto de Formulario.
                              controller: myController, 
                              //Se indica que lo que se escribirá dentro del campo de texto del formulario es texto o una cadena.
                              keyboardType: TextInputType.text, 

                              /*Se valida si el texto está vacío o si no comienza con
                                el símbolo @  o arroba. Si cumple con estas condiciones, se envía un mensaje de error*/
                              validator: (String arg) {
                                if (arg.isEmpty || (arg.startsWith('@') != true)) { 
                                  return 'You must type a valid Twitter username!';
                                }
                                return null;
                              },

                              maxLines: 1,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                filled: true,
                                hintText: 'Type  a valid @TwitterUsername',
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.only(
                                    left: 14.0, bottom: 10.0, top: 10.0),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: new BorderSide(color: Colors.white, width: 5.0),
                                  borderRadius: new BorderRadius.circular(25.7),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: new BorderSide(color: Colors.white, width: 5.0),
                                  borderRadius: new BorderRadius.circular(25.7),
                                ),
                                hintStyle: TextStyle(
                                    fontFamily: 'Roboto Light',
                                    fontWeight: FontWeight.normal,
                                    fontSize: 20,
                                    color: Colors.black26),
                              ),
                            ),

                            Container(

                              alignment: Alignment(0.0, 50.5),
                              height: 50.0,
                              child:

                              RaisedButton(
                                onPressed: () async //Recibe funciòn anónima. 
                                {
                                  if(_formKey.currentState.validate())
                                  {
                                    final snackBar = SnackBar(content: Text('Correct!'));
                                    globalKey.currentState.showSnackBar(snackBar);
                                    
                                    final search = new TweetFetchService();
                                    final results = await search.fetchTweets(myController.text.trim(), 10);

                                    Navigator.push
                                      (
                                      context,
                                      MaterialPageRoute(builder: (context) => DisplayedTweets(tweetstoDisplay: results,)),
                                    );//Se pasa a la segunda pantalla la informaciòn que necesita. 
                                  }
                                },

                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                                padding: EdgeInsets.all(0.0),
                                child: Ink(
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(colors: [Color(0xff374ABE), Color(0xff64B6FF)],
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                      ),
                                      borderRadius: BorderRadius.circular(30.0)
                                  ),
                                  child: Container(
                                    constraints: BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Search",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20.0
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            Text(
                              'This app allows you to track your child´s Twitter account. We don´t post anything on Twitter.com',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontFamily: 'Roboto Light',
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ]
                        ),
                        ),
                      ]),
                )),
          ),
        ),
      );
    }
  }

 

