from time import sleep
import json
import requests

class pessoal_inativo_api():

    def __init__(self, pessoal_inativo):
        self.endpoint_url = pessoal_inativo['endpoint_url']
        self.initial_offset = pessoal_inativo['initial_offset']
        self.is_full_load = bool(pessoal_inativo['is_full_load'])
        self.incremental_offset = pessoal_inativo['incremental_offset']
        self.file_number = pessoal_inativo['file_number']

    def get_items_from_api(self):
        parameters = {
            "offset": self.initial_offset
        }

        response = requests.request("GET", self.endpoint_url, params=parameters).json()

        all_items = {}
        all_items['items'] = []
        
        for item in response['items']:
            all_items['items'].append(item)
          
        all_items['file_number'] = self.file_number
        
        all_items['hasMore'] = response['hasMore']
        all_items['initial_offset'] = self.initial_offset + self.incremental_offset

        if len(all_items['items']) > 0:
            return all_items