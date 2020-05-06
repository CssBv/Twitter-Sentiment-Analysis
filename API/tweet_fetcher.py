import twitter
import sys
from twitter import *
import json
import os

def fetch_tweets(user_id, count): #Se crea método que extrae tweets.
    
    """Se indican claves de acceso,  así como un objeto de la clase Twitter del módulo Twitter con la finalidad
    #de poder accesar a la API de Twitter. Con el módulo OS se importan los tokens previamente establecidos como variables de entorno
    con la finalidad de tener más seguridad. """
    
    consumer_key = os.environ.get('consumer_key')
    consumer_secret = os.environ.get('consumer_secret')
    token = os.environ.get('token')
    token_secret = os.environ.get('token_secret')

    #Se accesa a la API por medio de instancia Twitter. Se pasan como parámetros las claves de acceso. 
    tw = Twitter(auth=OAuth(token, token_secret, 
                            consumer_key, consumer_secret))

    decoded_tweet = tw.statuses.user_timeline(   #Obtención de Tweets de un usuario.
        screen_name=user_id, count=count , tweet_mode='extended')
    
    #tweets = {"tweets": []} #Se crea un diccionario que contendrá tweets en forma de arreglo.
    tweets = []

    # cada tweet en tweets decodificados se agregará.
    for item in decoded_tweet:  #Se recorre cada elemento 
        date = item['created_at']   #Extrae únicamente los siguientes elementos del JSON extraído:
        id = item['id']             #Fecha de creación del tweet, id de tweet, id en cadena de tweet y el contenido del tweet (texto).
        id_str = item['id_str']
        full_text = item['full_text'] 
        
        tweet = Tweet(date, id, id_str, full_text)  #Objeto Tweet (Instancia de clase Ttweet)
    
        #tweets['tweets'].append(tweet)     #Se agrega el contenido extraído  al objeto.
        tweets.append(tweet) #Se agrega tweet a la lista tweets. 
    return tweets #Se retorna el contenido extraído.

class Tweet:    #La clase tweet es un modelo de un tweet.
    def __init__(self, created_at, id, id_str, full_text):
        self.created_at = created_at
        self.id = id
        self.id_str = id_str
        self.full_text = full_text