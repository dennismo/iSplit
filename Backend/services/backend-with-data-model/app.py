'''
Flask entry point file
'''
from flask import Flask
from flask_cors import CORS
from route import API_BP
import os

url_prefix = '/' + os.getenv('APP_2_CTX')
port = os.getenv('APP_2_PORT')

def create_app():
    '''
    Create flask app
    '''
    flask_app = Flask(__name__)
    flask_app.register_blueprint(API_BP, url_prefix=url_prefix)

    return flask_app


if __name__ == "__main__":
    APP = create_app()
    CORS(APP)
    APP.run(host='0.0.0.0', port=port, debug=True)
