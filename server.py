from flask import Flask, render_template, request
from werkzeug.utils import secure_filename
import os
os.environ["TF_CPP_MIN_LOG_LEVEL"] = "2"
import pandas as pd
import cv2
from glob import glob
import tensorflow as tf

from tensorflow.keras.utils import CustomObjectScope
from sklearn.metrics import accuracy_score, f1_score, jaccard_score, precision_score, recall_score
from metrics import dice_loss, dice_coef, iou

import matplotlib.pyplot as plt
import numpy as np
from matplotlib import colors
from matplotlib.ticker import PercentFormatter



with CustomObjectScope({'iou': iou, 'dice_coef': dice_coef, 'dice_loss': dice_loss}):
        model = tf.keras.models.load_model("model/model.h5")

        # y = y.flatten()
        # y_pred = y_pred.flatten()

app = Flask(__name__)

app.config['UPLOAD_FOLDER'] = 'uploaded/image'

@app.route('/')
def upload_f():
	return render_template('index.html')

def save_results(img, y_pred, save_image_path):
    line = np.ones((512, 10, 3)) * 255

    y_pred = np.expand_dims(y_pred, axis=-1)
    y_pred = np.concatenate([y_pred, y_pred, y_pred], axis=-1) * 255

    cat_images = np.concatenate([y_pred], axis=1)
    cv2.imwrite(save_image_path, cat_images)

    return

def finds(img):
    img = cv2.imread("uploaded/image/"+img.filename)
    img = img/255.0
    img = img.astype(np.float32)


    y_pred = model.predict(np.expand_dims(img, axis=0))[0]
    y_pred = ((y_pred-0.4)/(0.52-0.4))*255.0
        
    y_pred = y_pred > 180.0
        
    #y_pred = y_pred.astype(np.uint8)
    y_pred = y_pred.astype(np.int32)
    y_pred = np.squeeze(y_pred, axis=-1)
        

    return save_results(img, y_pred, "static/results/"+"result.jpg" )

    

@app.route('/uploader', methods = ['GET', 'POST'])
def upload_file():
	if request.method == 'POST':
		img = request.files['file']
		img.save(os.path.join(app.config['UPLOAD_FOLDER'],img.filename))
		finds(img)
		return render_template('result.html')

if __name__ == '__main__':
	app.run()




