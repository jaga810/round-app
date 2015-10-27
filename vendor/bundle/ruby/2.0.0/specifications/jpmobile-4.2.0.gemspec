# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "jpmobile"
  s.version = "4.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Shin-ichiro OGAWA", "Yoji Shidara"]
  s.date = "2014-12-22"
  s.description = "A Rails plugin for mobile devices in Japan"
  s.email = ["rust.stnard@gmail.com"]
  s.homepage = "http://jpmobile-rails.org"
  s.require_paths = ["lib"]
  s.rubygems_version = "2.0.14"
  s.summary = "A Rails plugin for mobile devices in Japan"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rails>, ["~> 4.2.0"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
      s.add_development_dependency(%q<rspec-rails>, [">= 0"])
      s.add_development_dependency(%q<rspec-its>, [">= 0"])
      s.add_development_dependency(%q<capybara-webkit>, [">= 0"])
      s.add_development_dependency(%q<geokit>, [">= 0"])
      s.add_development_dependency(%q<sqlite3-ruby>, [">= 0"])
      s.add_development_dependency(%q<hpricot>, [">= 0"])
      s.add_development_dependency(%q<git>, [">= 0"])
      s.add_development_dependency(%q<pry>, [">= 0"])
    else
      s.add_dependency(%q<rails>, ["~> 4.2.0"])
      s.add_dependency(%q<rspec>, [">= 0"])
      s.add_dependency(%q<rspec-rails>, [">= 0"])
      s.add_dependency(%q<rspec-its>, [">= 0"])
      s.add_dependency(%q<capybara-webkit>, [">= 0"])
      s.add_dependency(%q<geokit>, [">= 0"])
      s.add_dependency(%q<sqlite3-ruby>, [">= 0"])
      s.add_dependency(%q<hpricot>, [">= 0"])
      s.add_dependency(%q<git>, [">= 0"])
      s.add_dependency(%q<pry>, [">= 0"])
    end
  else
    s.add_dependency(%q<rails>, ["~> 4.2.0"])
    s.add_dependency(%q<rspec>, [">= 0"])
    s.add_dependency(%q<rspec-rails>, [">= 0"])
    s.add_dependency(%q<rspec-its>, [">= 0"])
    s.add_dependency(%q<capybara-webkit>, [">= 0"])
    s.add_dependency(%q<geokit>, [">= 0"])
    s.add_dependency(%q<sqlite3-ruby>, [">= 0"])
    s.add_dependency(%q<hpricot>, [">= 0"])
    s.add_dependency(%q<git>, [">= 0"])
    s.add_dependency(%q<pry>, [">= 0"])
  end
end
