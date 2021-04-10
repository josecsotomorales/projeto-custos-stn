from time import sleep
import json
import requests

class transferencia_api():

    def __init__(self, transferencia):
        self.endpoint_url = transferencia['endpoint_url']
        self.initial_offset = transferencia['initial_offset']
        self.is_full_load = bool(transferencia['is_full_load'])
        self.incremental_offset = transferencia['incremental_offset']
        self.file_number = transferencia['file_number']

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