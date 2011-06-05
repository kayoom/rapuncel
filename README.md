# Rapuncel - Simple XML-RPC Client

Rapuncel ([wikipedia](http://en.wikipedia.org/wiki/Rapunzel)) is a simple and lightweight, but fast XML-RPC client library for ruby.
It's based on Nokogiri for XML parsing and thus provides a major performance improvement for large XML responses.

## I need your help
I currently have exactly 1 application for Rapuncel, and that's [Kangaroo](https://github.com/cice/kangARoo), i.e.
the OpenERP XMLRPC service, where it works absolutely fine. To improve Rapuncel i need your experience with
other services and their quirks.
  
This Readme is for the upcoming 0.1 release, 0.0.x Readme [here](https://github.com/cice/rapuncel/blob/be19d4427dba14dbc656de1d90501f9d42aa4ef8/README.md) 

## Installation

### Rails
Add this to your Gemfile:

    gem 'rapuncel'

Run

    bundle install

and you're good to go.

### Other Ruby / IRB
Install it as gem:

    gem install rapuncel

Require **rubygems** and **rapuncel**

    require 'rubygems'
    require 'rapuncel'

## Usage

### Initialize client
Usage is pretty straightforward, Rapuncel provides a method proxy to send calls to your XMLRPC service like you would to a normal ruby
object.
First you have to create a client with the connection details, e.g.

    client = Rapuncel::Client.new :host => 'localhost', :port => 8080, :path => '/xmlrpc'

Available options are:

* **host**
hostname or ip-address,
_default_: localhost
* **port**
port where your XMLRPC service is listening,
_default_: 8080
* **path**
path to the service,
_default_: /
* **user**
Username for HTTP Authentication
_default_: _empty_
* **password**
Password for HTTP Authentication
_default_: _empty_
* **headers**
Hash to set additional HTTP headers for the request, e.g. to send an X-ApiKey header for authentication
_default_: {}
* **ssl**
Flag wether to use SSL
_default_: false
* **raise_on**
Lets you define the behavior on errors or faults, if set to _:fault_, _:error_ or _:both_,
an Exception will be raised if something goes wrong

### Get a proxy object and ...
A proxy object receives ruby method calls, redirects them to your XMLRPC service and returns the response as ruby objects!

    proxy = client.proxy

    # suppose your XMLRPC service has a method exposed 'concat_string(string1, string2)'
    proxy.concat_string "foo", "bar"
    -> "foobar"

    # if you need to access specific interfaces on your service, e.g. 'string.concat(string1, string2)'
    proxy = client.proxy_for 'string'
    proxy.concat 'foo', 'bar'
    -> 'foobar'

## Supported objects
Rapuncel supports natively following object-types (and all their subclasses):

* Integer
* String
* Array
* Hash
* TrueClass, FalseClass
* Float
* BigDecimal (treated like Float)
* Time, Time-like objects
* Base64

* Symbols are converted to Strings
* All Hashs have symbol keys
* All other objects are transformed into a Hash ('struct' in XMLRPC-speak) containing their instance variables as key-value-pairs.

## Base64
If you want a string to be encoded as Base64 in your RPC call, just mark it:

    proxy.some_method "my base64 encoded string".as_base64
    
Return values that arrive Base64 encoded, are instances of Rapuncel::Base64String,
which is a subclass of String, and therefore can be used as such, but allows you to differentiate
Base64 return values from normal String return values.

## Supported methods
You can use most methods via

    proxy.methodname *args

However methods starting with \_\_, or ending with a bang \! or a question mark ? are not supported. To call those methods you can always
use

    proxy.call! 'methodname', *args

or via

    client.call_to_ruby 'methodname', *args

note

    client.call 'methodname', *args

will return a Rapuncel::Response object, use _call\_to\_ruby_ to get standard ruby objects

## Deserialization options

At the moment there are 2 options, to be set quite ugly as class attributes on Rapuncel::XmlRpcDeserializer,
which will definitely change.

1. **double\_as\_bigdecimal**
Deserialize all <double> tags as BigDecimal.
2. **hash\_keys\_as\_string**
Don't use Symbols as keys for deserialized <struct>, but Strings.


## Todo ?

* RDoc
* Extensive functional tests
* HTTP-Proxy support
* Async requests
* XMLRPC Extensions (pluggable support)
* How do i test SSL?

## What happens if something goes wrong?
### HTTP Errors / XMLRPC Faults
See Usage -> configuration -> raise\_on switch
### Malformed XML/XMLRPC
Rapuncel will most likely fail hard.

## Open Source

### License

Copyright (c) 2010 ['Marian Theisen', 'Michael Eickenberg']

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

### Contribution

Pull requests are very welcome!