from flask import Flask, request, jsonify
import joblib
import numpy as np
import pickle

app = Flask(__name__)

# Load your trained machine learning model
file_path = 'iris_model_01.pkl'
model = None
# load the model
with open(file_path, 'rb') as file:
    model = pickle.load(file)


@app.route('/predict', methods=['POST'])
def predict():
    try:
        # Get data from the request
        data = request.get_json(force=True)
        
        # Assuming the data contains features 'SepalLengthCm', 'SepalWidthCm', 'PetalLengthCm', 'PetalWidthCm'
        features = [data['SepalLengthCm'], data['SepalWidthCm'], data['PetalLengthCm'], data['PetalWidthCm']]
        # features = [['sepal_length'],'[sepal_width]','[petal_length]', '[petal_width]']

        if model is None:
            print("Model has not been loaded properly!")
        else:
            prediction = model.predict(np.array(features).reshape(1, -1))
        # Return the prediction as JSON
        return jsonify({'prediction': prediction.tolist()})

    except Exception as e:
        return jsonify({'error': str(e)})

if __name__ == '__main__':
    app.run(port=5000)

