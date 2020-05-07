import flask #Se importa la librería Flask.
from flask import request, jsonify 
from flask.json import JSONEncoder
from tweet_fetcher import *
from tweet_classifier import * 

#La clase MyJSONEncoder tiene como objetivo codificar instancias de un tipo de dato en forma de objetos JSON. 
class MyJSONEncoder(JSONEncoder):       
    def default(self, obj):
        if isinstance(obj, Tweet):
            return {
                'created_at': obj.created_at, #Fecha de creación del tweet.
                'id': obj.id,   #ID del tweet.
                'id_str' : obj.id_str, #ID cadena del tweet.
                'full_text' : obj.full_text  #Contenido o texto del tweet. 
            }
        return super(MyJSONEncoder, self).default(obj)

app = flask.Flask(__name__) #Se crea una aplicación del framework Flask usando una instancia de la clase Flask.
app.json_encoder = MyJSONEncoder
app.config["DEBUG"] = True #Modo Debug activado.
tweet_classifier = TweetClassifier('~/Desktop/Copia de ExpertSystem/API/data/tweets_collection.txt')
#Se crea la ruta donde los tuits seràn recuperados.
@app.route('/api/v1/tweets', methods=['GET'])  
def get_tweets(): #Método de obtención de tuits. 

    #Diccionario con dos entradas. Para Tweets y errores. Inicialmente ambas están vacías. 
    response  = { "tweets" : [], "errors": [] }

    if 'user_id' in request.args:  
        user_id = request.args['user_id']
    else:
        #Se accede a la clave errores del diccionario respuesta. Devuelve una lista y a esa lista
        #Se le agrega un error. 
        response['errors'].append("User ID was not provided.") 
    
    if 'count' in request.args:
        count = request.args['count']
    else:
        #Marca error si el número de tweets no es indicado. 
        response['errors'].append("Count was not provided.") 

    if (len(response["errors"]) > 0):
        return response

    try:
        # Recupera count tweets para user_id de Twitter y lo almacena en variable tweets. 
        tweets = fetch_tweets(user_id, count) 
        classified_tweets = tweet_classifier.classify(tweets)
    except Exception as err:
        response['errors'].append('An error has occured!')
        return jsonify(response)
    negative_tweets = []
    for i in range(0,len(classified_tweets)):
        if(classified_tweets[i] == 1):
            negative_tweets.append(tweets[i])

    #Se redefine el valor de la clave tweets. 
    response['tweets'] = negative_tweets

    return jsonify(response) #Se Jsonifican tweets.
   
app.run(host="192.168.15.2", port="5000") #Corre aplicacion
            
