import re
import pandas as pd
from nltk import *
from sklearn.model_selection import train_test_split
from sklearn.feature_extraction.text import CountVectorizer
from sklearn.naive_bayes import MultinomialNB
from sklearn.metrics import accuracy_score, precision_score, recall_score, f1_score


"""Se inicializa la clase por medio del constructor que toma como argumentos  la palabra reservada
   self y la ruta donde se encuentra el archivo 
   que contiene los datos de entrenamiento."""

class TweetClassifier:
    
    def __init__(self, dataset_path):
        #Se dividen los datos de entrenamiento por medio del método split de la librería ScikitLearn tomando como argumento la ruta de los datos. 
        self.x_train, self.x_test, self.y_train, self.y_test = self._split_dataset(dataset_path)
        """Se utiliza el parámetro stop_words de la clase CountVectorizer para no tomar en cuenta palabras comunes del idioma inglés
        que podrían sesgar el análisis. Por ejemplo, xyconjunciones y/o pronombres."""
        self.count_vector = CountVectorizer(stop_words='english')
        #Se agregan los datos de entrenamiento a la matriz para el análisis.
        self.training_data = self.count_vector.fit_transform(self.x_train)
        #Aplica el modelo de transformación a datos de prueba. 
        self.testing_data = self.count_vector.transform(self.x_test)
        """Se instancia un objeto de la clase MultinomoialNB() (Naive Bayes multinomial) de la librería ScikitLearn
        Este objeto servirá como el clasificador de Tweets."""
        self.naive_bayes = MultinomialNB()
        #Se ajustan datos de entrenamiento en el objeto clasificador. 
        self.naive_bayes.fit(self.training_data, self.y_train)
        """Se usa el método predict() de la lib rería ScikitLearn para predecir le efectividad del modelo de clasificación utilizando
        los datos de prueba."""
        self.predictions = self.naive_bayes.predict(self.testing_data)
    
    #El método privado _split_datatset establece la ruta del archivo que contiene los datos de entrenamiento.
    def _split_dataset(self, dataset_path):
        
        """Se utiliza el método read_table de la librería Pandas para leer el archivo de los datos de entrenamiento en forma de tabla.
        Se reciben como argumentos, la ruta del archivo de datos de entrenamiento, se indica la separación de columnas por medio de tab,
        se indican las columnas utilizando el parámetro names  y se indica la codificación del archivo (en este caso será utf-8)
         """
        
        df = pd.read_table(dataset_path, 
                   sep='\t', 
                   names=['label','tweet'], encoding= 'utf-8')

        #Se convierten las etiquetas del archivo de los datos de entrenamiento en variables binarias.
        df['label'] = df.label.map({'notharmful':0, 'harmfuyes':1})
        #Se indica que los datos de entrenamiento siempre deben tener los mismos valores. Para esto se utiliza el parámetro random_state
        return train_test_split(df['tweet'], df['label'], random_state=1)
    #El método classify se encarga de preprocesar los tweets del usuario tecleado desde la aplicación para posteriormente clasificarlos.
    def classify(self, tweets):
        #Se declara un arreglo
        data = []
        #Se recorren todos los tweets del usuario encontrados. 
        for tweet in tweets:

            #print(tweet.full_text)
            text = tweet.full_text
            #Se quitan mayúsculas
            text = text.lower()
            #Se remueven URLs
            text = re.sub('((www\.[^\s]+)|(https?://[^\s]+))', '', text)
            #Se remueven usuarios etiquetados del Tweet.
            text = re.sub('@[^\s]+', '', text)
            #Se remueve símbolo # de los hashtags
            text = re.sub(r'#([^\s]+)', r'\1', text)
            #Se adjunta al arreglo data, el texto de los tweets preprocesados.
            data.append(text)
        #Se retorna la predicción de los tweets encontrados.
        return self.naive_bayes.predict(self.count_vector.transform(data))
    
    """Se utiliza la función __Str__ de Python para representar en forma de cadena los objetos de predicción, 
    exactitud", recall y puntaje f1"""
    def __str__(self):
        return [
            'Accuracy score: ', format(accuracy_score(self.y_test, self.predictions)), #Exactitud
            'Precision score: ', format(precision_score(self.y_test, self.predictions)), #Precisión
            'Recall score: ', format(recall_score(self.y_test, self.predictions)), #Sensibilidad
            'F1 score: ', format(f1_score(self.y_test, self.predictions)) #Puntuación F1
        ]
    
    #Indica el tamaño de la colección de datos de entrenamiento.
    def get_data_size(self):
        return [
            'Number of rows in the total set: {}'.format(self.x_train.shape[0] + self.x_test.shape[0]), #se calcula el total de filas en la coleccióm.
            'Number of rows in the training set: {}'.format(self.x_train.shape[0]),#Total de filas destinadas a ser datos de entrenamiento.
            'Number of rows in the test set: {}'.format(self.x_test.shape[0])#Total de dilas destinadas a ser datos de prueba.
        ]
        
