# -*- encoding: utf-8 -*-
# stub: flutter_analyze_parser 0.1.2 ruby lib

Gem::Specification.new do |s|
  s.name = "flutter_analyze_parser".freeze
  s.version = "0.1.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Mateusz Szklarek".freeze]
  s.date = "2019-03-14"
  s.email = ["mateusz.szklarek@gmail.com".freeze]
  s.homepage = "https://github.com/mateuszszklarek/flutter-analyze-parser".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.2.3".freeze
  s.summary = "Parser for flutter analyze output".freeze

  s.installed_by_version = "3.2.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_development_dependency(%q<guard-rspec>.freeze, ["~> 4.7"])
    s.add_development_dependency(%q<rake>.freeze, ["~> 10.0"])
    s.add_development_dependency(%q<rb-readline>.freeze, ["~> 0.5"])
    s.add_development_dependency(%q<rspec>.freeze, ["~> 3.0"])
    s.add_development_dependency(%q<rubocop>.freeze, ["~> 0.6"])
    s.add_development_dependency(%q<simplecov>.freeze, ["~> 0.16"])
    s.add_development_dependency(%q<codecov>.freeze, ["~> 0.1"])
  else
    s.add_dependency(%q<guard-rspec>.freeze, ["~> 4.7"])
    s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
    s.add_dependency(%q<rb-readline>.freeze, ["~> 0.5"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.0"])
    s.add_dependency(%q<rubocop>.freeze, ["~> 0.6"])
    s.add_dependency(%q<simplecov>.freeze, ["~> 0.16"])
    s.add_dependency(%q<codecov>.freeze, ["~> 0.1"])
  end
end
