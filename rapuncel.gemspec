Gem::Specification.new do |s|
  s.name        = "rapuncel"
  s.version     = "0.0.1.alpha"
  s.date        = Time.now.strftime("%Y-%m-%d")
  s.authors     = ["Michael Eickenberg", "Marian Theisen"]
  s.email       = 'marian@cice-online.net'
  s.summary     = "Simple XML-RPC Client"
  s.homepage    = "http://github.com/cice/rapuncel"
  s.description = "Simple XML-RPC Client"

  s.files        =  Dir["**/*"] -
                    Dir["coverage/**/*"] -
                    Dir["rdoc/**/*"] -
                    Dir["doc/**/*"] -
                    Dir["sdoc/**/*"] -
                    Dir["rcov/**/*"]

  s.add_dependency 'nokogiri'
  s.add_dependency 'builder'
  s.add_dependency 'activesupport', '>= 3.0.0'
  
  s.add_development_dependency 'mocha'
end
