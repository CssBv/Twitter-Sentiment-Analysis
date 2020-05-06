import 'dart:convert';
import 'package:expert_system/Models/tweet.dart';
import 'package:http/http.dart' as http;



class TweetFetchService {
  /*Mètodo asìncrono que no bloquea la interfaz de usuario. Se escribe async después del nombre del método.
  Cuando un mètodo es asìncrono siempre devuelve un futuro. Un futuro es genèrico.  Pasaremos una lista de Tweets.*/

    Future <List<Tweet>> fetchTweets(String username, int tweetCount) async  {

      /*Se hace una petición a la Web API por medio del módulo HTTP de dart.*/
    final response = await http.get('http://189.213.18.165:5000/api/v1/tweets?user_id=$username&count=$tweetCount'); //Interpolacion de cadenas.

    if (response.statusCode == 200) {
      
      /*Body contiene dos elementos: tweets y su valor respectivo (para cada tweet) y errores y su posible valor. */
      final body = json.decode(response.body);

      /*
      final errors = body['errors'];
      if(errors.isNotEmpty()){
        //throw Exception(errors);
      }*/

      /*RawTweets devuelve la lista de tweets que permanecen en bodies porque se indica la clave tweets. */
      final rawTweets = body['tweets'];
      /*Lista de objetos de la clase Tweet.*/
      final tweets = <Tweet>[];

      /*Para cada tweet crudo en la lista tweets, se crea una instancia de la clase Tweet. y se agregan a una lista.*/
      for (var rawTweet in rawTweets){
       tweets.add(Tweet(rawTweet));      
      }                                     
 
      return tweets;
    } 
    else{
      /*Si la respuesta no es exitosa, lanzar una excepción.*/
      throw Exception('Failed to obtain Tweets. Try again.');
    }
    



    // Creating the twitterApi Object with the secret and public keys
    // These keys are generated from the twitter developer page
    // Dont share the keys with anyone
    
  //   //Se conecta a la API de Twitter por medio de claves.
    // final _twitterOauth = new twitterApi(
    //     consumerKey: 'MWmoyb2wErt0sEaIqrTXwRcXy',
    //     consumerSecret: 'e3InmGRySinXcY3DhvRyc4SacSjaqZI2P4bxHyayg3aWlYMuK9',
    //     token: '1147317633920000000-3MPt5xnW86nCBDGSNT6sHFYuzqHjIS',
    //     tokenSecret: 'J1IY0jJScjGuFbQ5P1lPGvySrB2VhUhujHtKpXA4NreQA');

    // // Se hace una petición a Twitter.
    // Future twitterRequest = _twitterOauth.getTwitterRequest(
    //   // Http Method
    //   "GET",
    //   // Endpoint you are trying to reach
    //   "statuses/user_timeline.json",
    //   // The options for the request
    //   options: {
    //     //"user_id": "elonmusk",
    //     "screen_name": username, //Se parametriza el nombre de usuario que el usuario escribirá desde la interfaz. 
    //     "count": tweetCount.toString(), //Se parametriza los tuits que se mostrarán. 
    //     "trim_user": "true",
    //     "include_rts": "false",
    //     "exclude_replies": "true",
    //     "tweet_mode": "extended",
    //     // Used to prevent truncating tweets
    //   },
    // );

    // // Se espera a que el Futuro termine.
    // var res = await twitterRequest;

    // // Convert the string response into something more useable
    // var tweetsDecoded = json.decode(res.body);

    // final tweets = <Tweet>[];

    // for (var  rawTweet in tweetsDecoded) {
    //   var tweet = Tweet(rawTweet);
    //   tweets.add(tweet);
    // }
    // return tweets;
  }
}
