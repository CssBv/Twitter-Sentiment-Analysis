import 'package:expert_system/Services/tweet_fetch_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

//Pruebas unitarias
main() async {
  final fetchService = TweetFetchService();
  final coleccionTweets = await fetchService.fetchTweets(
        'LewisOfTime', 2);
  group('Tweet fetch service', ()  {
     //Escribe el nombre de usuario y el nùmero de tuits.
    test('El tamaño deberá coincidir.',
        ()  //Se escribe async porque el metodo del servicio es asincròno.
        {
      expect(coleccionTweets.length, 100);
    });
      
      for(final tweet in coleccionTweets)
      {
        debugPrint(tweet.toString());
      }

  });
}
