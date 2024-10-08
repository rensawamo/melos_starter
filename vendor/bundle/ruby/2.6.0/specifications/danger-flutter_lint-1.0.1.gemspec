# -*- encoding: utf-8 -*-
# stub: danger-flutter_lint 1.0.1 ruby lib

Gem::Specification.new do |s|
  s.name = "danger-flutter_lint".freeze
  s.version = "1.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Mateusz Szklarek".freeze]
  s.date = "2019-04-06"
  s.email = ["mateusz.szklarek@gmail.com".freeze]
  s.homepage = "https://github.com/mateuszszklarek/danger-flutterlint".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.2.3".freeze
  s.summary = "A Danger Plugin to lint dart files using flutter analyze command line interface.".freeze

  s.installed_by_version = "3.2.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<danger-plugin-api>.freeze, ["~> 1.0"])
    s.add_runtime_dependency(%q<flutter_analyze_parser>.freeze, ["~> 0.1.2"])
    s.add_development_dependency(%q<codecov>.freeze, ["~> 0.1"])
    s.add_development_dependency(%q<guard-rspec>.freeze, ["~> 4.7"])
    s.add_development_dependency(%q<rake>.freeze, ["~> 10.0"])
    s.add_development_dependency(%q<rb-readline>.freeze, ["~> 0.5"])
    s.add_development_dependency(%q<rspec>.freeze, ["~> 3.0"])
    s.add_development_dependency(%q<rubocop>.freeze, ["~> 0.6"])
    s.add_development_dependency(%q<simplecov>.freeze, ["~> 0.16"])
  else
    s.add_dependency(%q<danger-plugin-api>.freeze, ["~> 1.0"])
    s.add_dependency(%q<flutter_analyze_parser>.freeze, ["~> 0.1.2"])
    s.add_dependency(%q<codecov>.freeze, ["~> 0.1"])
    s.add_dependency(%q<guard-rspec>.freeze, ["~> 4.7"])
    s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
    s.add_dependency(%q<rb-readline>.freeze, ["~> 0.5"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.0"])
    s.add_dependency(%q<rubocop>.freeze, ["~> 0.6"])
    s.add_dependency(%q<simplecov>.freeze, ["~> 0.16"])
  end
end
