'''
Controller for route /Server2
'''
import requests
import os
from flask_restful import Resource
from model.trdata import Trdata as TrDataModel

class Server2(Resource):
    '''
    CRUD operation method for /server2    
    '''

    def get(self):
        '''
        Return if the container is up
        '''
        server_2_url = os.environ['SERVICE_1_URL']
        r = requests.get(server_2_url + '/health')
        return r.json()
