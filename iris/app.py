from flask import Flask, request, jsonify
import joblib
import numpy as np

app = Flask(__name__)

# Load your trained machine learning model
model = joblib.load('IRIS-model.pkl')

@app.route('/predict', methods=['GET', 'POST'])
def predict():
    try:
        # Get data from the request
        data = request.get_json(force=True)
        
        # Assuming the data contains features 'sepal_length', 'sepal_width', 'petal_length', 'petal_width'
        features = [data['sepal_length'], data['sepal_width'], data['petal_length'], data['petal_width']]
        # features = [['sepal_length'],'[sepal_width]','[petal_length]', '[petal_width]']
        
        # Make a prediction
        prediction = model.predict(np.array(features).reshape(1, -1))

        # Return the prediction as JSON
        return jsonify({'prediction': prediction.tolist()})

    except Exception as e:
        return jsonify({'error': str(e)})

if __name__ == '__main__':
    app.run(port=5000)