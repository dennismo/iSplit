'''
Controller for route /health
'''
from flask_restful import Resource
from model.trdata import Trdata as TrDataModel
import os

class Health(Resource):
    '''
    CRUD operation method for /health    
    '''

    def get(self):
        '''
        Return if the container is up
        '''
        return {
            'status': 'backend 2 is up'
        }
