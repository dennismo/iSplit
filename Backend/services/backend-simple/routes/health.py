'''
Controller for route /health
'''
from flask_restful import Resource

class Health(Resource):
    '''
    CRUD operation method for /health    
    '''

    def get(self):
        '''
        Return if the container is up
        '''
        return {
            'status': 'backend 1 is up'
        }
