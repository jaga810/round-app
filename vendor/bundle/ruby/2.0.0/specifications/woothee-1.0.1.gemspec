# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "woothee"
  s.version = "1.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["TAGOMORI Satoshi"]
  s.date = "2015-01-14"
  s.description = "Cross-language UserAgent classifier library, ruby implementation"
  s.email = "tagomoris@gmail.com"
  s.homepage = "https://github.com/woothee/woothee-ruby"
  s.require_paths = ["lib"]
  s.rubygems_version = "2.0.14"
  s.summary = "Cross-language UserAgent classifier library, ruby implementation"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 2.8.0"])
    else
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 2.8.0"])
    end
  else
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 2.8.0"])
  end
end
