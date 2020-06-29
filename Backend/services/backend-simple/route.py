'''
Router config file
'''
from flask import Blueprint
from flask_restful import Api
from routes.health import Health

API_BP = Blueprint('api', __name__)
API = Api(API_BP)

# Routes
API.add_resource(Health, '/health')
