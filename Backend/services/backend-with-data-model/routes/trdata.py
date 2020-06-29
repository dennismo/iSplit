'''
Controller for route /trdata
'''
from flask_restful import Resource
from model.trdata import Trdata as TrDataModel

class Trdata(Resource):
    '''
    CRUD operation method for /trdata    
    '''

    def get(self):
        '''
        Get story count by language JSON object from model and pass it to client
        '''
        
        tr_data_model = TrDataModel('datas/count_by_data.json')
        json_data = tr_data_model.get_json_data()

        return {
            'datas': json_data
        }
