'''
To serve data to controller of the apps
'''
import json

class Trdata:
    '''
    This class will serve converted JSON data from dataframe to controllers
    '''
    def __init__(self, datafile):
        self.datafile = datafile

    # TODO: Ideally it would be NoSQL DB instead of plain json    
    def get_json_data(self):
        '''
        Read converted JSONfile that was preprocessed and serve it to controller as dataframe
        Ideally instead of reading from JSONfile it should read data from a database
        '''
        json_file =  open(self.datafile, 'r')
        data = json.load(json_file)
        json_file.close()
        return data

