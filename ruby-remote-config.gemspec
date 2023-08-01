# Generated by juwelier
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Juwelier::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-
# stub: ruby-remote-config 1.0.0 ruby lib

Gem::Specification.new do |s|
  s.name = "ruby-remote-config".freeze
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["divakarmanoj".freeze]
  s.date = "2023-08-01"
  s.description = "this is a simple gem that implements a remote config. It can accept different types of remote source and can be used to fetch config from them.".freeze
  s.email = "manoj.prithvee@gmail.com".freeze
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files = [
    ".document",
    ".idea/.gitignore",
    ".idea/misc.xml",
    ".idea/modules.xml",
    ".idea/ruby-remote-config.iml",
    ".idea/vcs.xml",
    ".rspec",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "lib/file_repository.rb",
    "lib/gcp_storage_repository.rb",
    "lib/repository.rb",
    "lib/ruby_remote_config.rb",
    "lib/web_repository.rb",
    "ruby-remote-config.gemspec",
    "spec/file_repository_spec.rb",
    "spec/gcp_storage_repository_spec.rb",
    "spec/ruby_remote_config_spec.rb",
    "spec/spec_helper.rb",
    "spec/test.yaml",
    "spec/web_repository_spec.rb"
  ]
  s.homepage = "http://github.com/divakarmanoj/ruby-remote-config".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.2.33".freeze
  s.summary = "this is a simple gem that implements a remote config".freeze

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<google-cloud-storage>.freeze, ["~> 1.44"])
    s.add_development_dependency(%q<shoulda>.freeze, [">= 0"])
    s.add_development_dependency(%q<bundler>.freeze, ["~> 2.2"])
    s.add_development_dependency(%q<juwelier>.freeze, ["~> 2.1.0"])
    s.add_development_dependency(%q<simplecov>.freeze, [">= 0"])
    s.add_development_dependency(%q<rspec>.freeze, [">= 0"])
  else
    s.add_dependency(%q<google-cloud-storage>.freeze, ["~> 1.44"])
    s.add_dependency(%q<shoulda>.freeze, [">= 0"])
    s.add_dependency(%q<bundler>.freeze, ["~> 2.2"])
    s.add_dependency(%q<juwelier>.freeze, ["~> 2.1.0"])
    s.add_dependency(%q<simplecov>.freeze, [">= 0"])
    s.add_dependency(%q<rspec>.freeze, [">= 0"])
  end
end

