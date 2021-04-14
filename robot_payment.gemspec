Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'robot_payment'
  s.version     = '0.3'
  s.summary     = 'Robot Payment rails helper'
  s.description = ""
  s.required_ruby_version = '>= 2.6.0'

  s.author    = 'digitalm'
  s.email     = 'digitalm.github@gmail.com'
  s.homepage  = 'https://github.com/knowledgelabo'

  s.files       = `git ls-files`.split("\n")
  s.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency 'faraday', '>= 1.0'
  s.add_dependency 'json', '>= 1.8'

end