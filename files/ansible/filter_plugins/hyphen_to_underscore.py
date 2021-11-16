class FilterModule(object):

    def filters(self):
        return {
            'hyphen_to_underscore': self.hyphen_to_underscore,
        }
    
    def hyphen_to_underscore(self, dirty_json):
        clean_json = dirty_json

        if isinstance(dirty_json,list):
            clean_json = []
            for item in dirty_json:
                clean_json.append(self.hyphen_to_underscore(item))

        elif isinstance(dirty_json,dict):
            clean_json = {}
            for k, v in dirty_json.items():
                if isinstance(dirty_json[k], dict) or isinstance(dirty_json[k], list):
                    value = self.hyphen_to_underscore(v)
                    clean_json[k.replace('-', '_')] = value
                else:
                    clean_json[k.replace('-', '_')] = v

        return clean_json
