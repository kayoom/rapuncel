# Rapuncel - Simple XML-RPC Client

Rapuncel ([wikipedia](http://en.wikipedia.org/wiki/Rapunzel)) is a simple and lightweight, but fast XML-RPC client library for ruby. 
It's based on Nokogiri for XML parsing and thus provides a major performance improvement for large XML responses. 

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
Username for HTTP Authentication  
_default_: _empty_
* **auth\_method**
HTTP Auth method  
_default_: basic **IF** user or password is set
* **api\_key**
If set, sends all request with a X-ApiKey: _api\_key_ header
* **api\_key\_header**
Allows you to modify the header key for API-Key auth
_default_: X-ApiKey

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
* Time

All other objects are transformed into a Hash ('struct' in XMLRPC-speak) containing their instance variables as key-value-pairs.

## Supported methods
You can use most methods via

    proxy.methodname *args
    
However methods starting with \_\_, or ending with a bang \! or a question mark ? are not supported. To call those methods you can always
use

    proxy.call! methodname, *args
    
or via

    client.call_to_ruby methodname, *args
    
note client.call methodname, \*args will return a Rapuncel::Response object, use _call\_to\_ruby_ to get standard ruby objects