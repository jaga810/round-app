# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "formtastic-bootstrap"
  s.version = "3.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Matthew Bellantoni", "Aaron Stone"]
  s.date = "2015-07-19"
  s.description = "Formtastic form builder to generate Twitter Bootstrap-friendly markup."
  s.email = ["mjbellantoni@yahoo.com", "aaron@serendipity.cx"]
  s.extra_rdoc_files = ["LICENSE.txt", "README.md"]
  s.files = ["LICENSE.txt", "README.md"]
  s.homepage = "http://github.com/mjbellantoni/formtastic-bootstrap"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "2.0.14"
  s.summary = "Formtastic form builder to generate Twitter Bootstrap-friendly markup."

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<formtastic>, [">= 3.0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<tzinfo>, [">= 0"])
      s.add_development_dependency(%q<bundler>, [">= 0"])
      s.add_development_dependency(%q<nokogiri>, ["< 1.6.0"])
      s.add_development_dependency(%q<rspec_tag_matchers>, ["~> 1.0"])
      s.add_development_dependency(%q<ammeter>, ["~> 0.2"])
      s.add_development_dependency(%q<actionpack>, ["~> 3.2"])
    else
      s.add_dependency(%q<formtastic>, [">= 3.0"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<tzinfo>, [">= 0"])
      s.add_dependency(%q<bundler>, [">= 0"])
      s.add_dependency(%q<nokogiri>, ["< 1.6.0"])
      s.add_dependency(%q<rspec_tag_matchers>, ["~> 1.0"])
      s.add_dependency(%q<ammeter>, ["~> 0.2"])
      s.add_dependency(%q<actionpack>, ["~> 3.2"])
    end
  else
    s.add_dependency(%q<formtastic>, [">= 3.0"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<tzinfo>, [">= 0"])
    s.add_dependency(%q<bundler>, [">= 0"])
    s.add_dependency(%q<nokogiri>, ["< 1.6.0"])
    s.add_dependency(%q<rspec_tag_matchers>, ["~> 1.0"])
    s.add_dependency(%q<ammeter>, ["~> 0.2"])
    s.add_dependency(%q<actionpack>, ["~> 3.2"])
  end
end
