class FilterModule(object):

    def filters(self):
        return {
            'xml_to_json': self.xml_to_json,
        }

    def xml_to_json(self, value):
        import xmltodict, json
        return json.dumps(xmltodict.parse(value))
