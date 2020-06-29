'''
Router config file
'''
from flask import Blueprint
from flask_restful import Api
from routes.trdata import Trdata
from routes.health import Health
from routes.server2 import Server2

API_BP = Blueprint('api', __name__)
API = Api(API_BP)

# Routes
API.add_resource(Trdata, '/trdata')
API.add_resource(Health, '/health')
API.add_resource(Server2, '/server2')
