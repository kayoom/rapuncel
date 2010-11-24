## {{{ http://code.activestate.com/recipes/81549/ (r1)
# Server code

import SimpleXMLRPCServer

class StringFunctions:
    def __init__(self):
        # Make all of the Python string functions available through
        # python_string.func_name
        import string
        self.python_string = string

    def _privateFunction(self):
        # This function cannot be called through XML-RPC because it
        # starts with an '_'
        pass

    def chop_in_half(self, astr):
        return astr[:len(astr)/2]

    def repeat(self, astr, times):
        return astr * times

server = SimpleXMLRPCServer.SimpleXMLRPCServer(("localhost", 8000))
server.register_instance(StringFunctions())
server.register_function(lambda astr: '_' + astr, '_string')
server.serve_forever()