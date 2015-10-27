# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "mobylette"
  s.version = "3.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Tiago Scolari"]
  s.date = "2013-09-19"
  s.description = "Adds the mobile format for rendering views for mobile device."
  s.email = ["tscolari@gmail.com"]
  s.homepage = "https://github.com/tscolari/mobylette"
  s.require_paths = ["lib"]
  s.rubygems_version = "2.0.14"
  s.summary = "Mobile request handling for your Rails app."

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<actionpack>, [">= 3.0"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
      s.add_development_dependency(%q<rspec-rails>, [">= 0"])
    else
      s.add_dependency(%q<actionpack>, [">= 3.0"])
      s.add_dependency(%q<rspec>, [">= 0"])
      s.add_dependency(%q<rspec-rails>, [">= 0"])
    end
  else
    s.add_dependency(%q<actionpack>, [">= 3.0"])
    s.add_dependency(%q<rspec>, [">= 0"])
    s.add_dependency(%q<rspec-rails>, [">= 0"])
  end
end
