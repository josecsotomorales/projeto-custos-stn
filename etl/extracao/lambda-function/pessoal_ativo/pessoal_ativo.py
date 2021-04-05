from time import sleep
import json
import requests
class pa_api():
    def get_files_by_endpoint(self, pessoal_ativo_state, bucket, bucket_name):
        obj_write = bucket.Object('custo-stn-sources.json')
        data = obj_write.get()['Body'].read()
        custo_stn_sources = json.loads(data)
        pessoal_ativo = custo_stn_sources['sources']['pessoal_ativo']
        
        
        if pessoal_ativo_state['is_full_load'] is True:
            pessoal_ativo['initial_offset'] = 250
            pessoal_ativo['file_number'] = 0
            obj_write.put(Body=json.dumps(custo_stn_sources))
            
            
            url = pessoal_ativo_state['endpoint_url']
            
            all_items = {}
            all_items['items'] = []
            response = requests.request("GET", url).json()
            
            for item in response['items']:
                all_items['items'].append(item)
            
            file_number = pessoal_ativo['file_number']
            hasMore = response['hasMore']
            initial_offset = pessoal_ativo['initial_offset'] + 250
            if len(all_items['items']) > 0:
                obj_write_file = bucket.Object(f'pessoal_ativo/pessoal_ativo_{file_number}.json')
                obj_write_file.put(Body=json.dumps(all_items))
                obj_write = bucket.Object('custo-stn-sources.json')
                file_number += 1
                data = obj_write.get()['Body'].read()
                custo_stn_sources = json.loads(data)
                pessoal_ativo = custo_stn_sources['sources']['pessoal_ativo']
                pessoal_ativo['initial_offset'] = initial_offset
                pessoal_ativo['file_number'] = file_number
                obj_write.put(Body=json.dumps(custo_stn_sources))
                
            
            while hasMore and initial_offset <= 500:
              sleep(5)
              parameters = {
                "offset": initial_offset
              }
              all_items = {}
              all_items['items'] = []
              response = requests.request("GET", url, params=parameters).json()
              for item in response['items']:
                  all_items['items'].append(item)
            
              hasMore = response['hasMore']
              initial_offset = response['offset'] 
              initial_offset += 250
              
              obj_write = bucket.Object('custo-stn-sources.json')
              data = obj_write.get()['Body'].read()
              custo_stn_sources = json.loads(data)
              pessoal_ativo = custo_stn_sources['sources']['pessoal_ativo']
              pessoal_ativo['initial_offset'] = initial_offset
              obj_write.put(Body=json.dumps(custo_stn_sources))
              
              obj = bucket.Object(f'pessoal_ativo/pessoal_ativo_{file_number}.json')
              obj.put(Body=json.dumps(all_items))
              file_number +=1
              obj_write = bucket.Object('custo-stn-sources.json')
              data = obj_write.get()['Body'].read()
              custo_stn_sources = json.loads(data)
              pessoal_ativo = custo_stn_sources['sources']['pessoal_ativo']
              pessoal_ativo['file_number'] = file_number
              obj_write.put(Body=json.dumps(custo_stn_sources))
    
        elif not pessoal_ativo['is_full_load']:
            url = pessoal_ativo['endpoint_url']
            file_number = pessoal_ativo["file_number"]
            all_items = {}
            all_items['items'] = []
            initial_offset = pessoal_ativo['initial_offset'] + 250
            parameters = {
              "offset": initial_offset
            }
            
            response = requests.request("GET", url, params=parameters).json()
            for item in response['items']:
                all_items['items'].append(item)
            
            hasMore = response['hasMore']
            
            if len(all_items['items']) > 0:
                obj_write_file = bucket.Object(f'pessoal_ativo/pessoal_ativo_{file_number}.json')
                obj_write_file.put(Body=json.dumps(all_items))
                obj_write = bucket.Object('custo-stn-sources.json')
                data = obj_write.get()['Body'].read()
                custo_stn_sources = json.loads(data)
                pessoal_ativo = custo_stn_sources['sources']['pessoal_ativo']
                pessoal_ativo['initial_offset'] = initial_offset
                pessoal_ativo['file_number'] = file_number
                obj_write.put(Body=json.dumps(custo_stn_sources))

            
            while hasMore and initial_offset <= 1250:
              sleep(5)
              parameters = {
                "offset": initial_offset
              }
              all_items = {}
              all_items['items'] = []
            
              response = requests.request("GET", url, params=parameters).json()
              for item in response['items']:
                  all_items['items'].append(item)
            
              hasMore = response['hasMore']
              initial_offset = response['offset'] 
              initial_offset += 250
              
              obj_write = bucket.Object('custo-stn-sources.json')
              data = obj_write.get()['Body'].read()
              custo_stn_sources = json.loads(data)
              pessoal_ativo = custo_stn_sources['sources']['pessoal_ativo']
              pessoal_ativo['initial_offset'] = initial_offset
              obj_write.put(Body=json.dumps(custo_stn_sources))
              
              obj = bucket.Object(f'pessoal_ativo/pessoal_ativo_{file_number}.json')
              obj.put(Body=json.dumps(all_items))
            
              file_number +=1
              
        obj_write = bucket.Object('custo-stn-sources.json')
        data = obj_write.get()['Body'].read()
        custo_stn_sources = json.loads(data)
        pessoal_ativo = custo_stn_sources['sources']['pessoal_ativo']
        pessoal_ativo['is_full_load'] = False
        obj_write.put(Body=json.dumps(custo_stn_sources))