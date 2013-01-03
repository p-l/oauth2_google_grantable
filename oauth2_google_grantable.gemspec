# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require 'devise/oauth2_google_grantable/version'

Gem::Specification.new do |s|
  s.name        = "oauth2_google_grantable"
  s.version     = Devise::OAuth2GoogleGrantable::VERSION
  s.authors     = ["Pierre-Luc Simard"]
  s.email       = ["p-l@6x9.ca"]
  s.homepage    = "http://github.com/p-l/oauth2_google_grantable"
  s.summary     = %q{Google grant type for OAuth2 authentication}
  s.description = %q{Add google as a grant_type to the authentication done through devise_oauth2_providable}

  s.rubyforge_project = "oauth2_google_grantable"

  # specify any dependencies here; for example:
  s.add_runtime_dependency "devise_oauth2_providable", "~> 1.1.0"
  s.add_runtime_dependency 'json'

  s.files         = `git ls-files`.split("\n")

  s.test_files    = `git ls-files -- {tests,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

end
