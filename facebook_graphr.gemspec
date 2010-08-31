# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{facebook_graphr}
  s.version = "0.1.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Kevin Ball"]
  s.date = %q{2010-08-31}
  s.description = %q{A lightweight gem for dealing with Facebook's new Open Graph API}
  s.email = %q{kmball11@gmail.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "facebook_graphr.gemspec",
     "init.rb",
     "lib/facebook_graphr.rb",
     "lib/facebook_graphr/controller.rb",
     "lib/facebook_graphr/helpers.rb",
     "rails/init.rb",
     "test/helper.rb",
     "test/test_facebook_graphr.rb"
  ]
  s.homepage = %q{http://github.com/kball/facebook_graphr}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{A gem for dealing with Facebook's new graph API}
  s.test_files = [
    "test/helper.rb",
     "test/test_facebook_graphr.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<thoughtbot-shoulda>, [">= 0"])
      s.add_runtime_dependency(%q<httparty>, [">= 0"])
    else
      s.add_dependency(%q<thoughtbot-shoulda>, [">= 0"])
      s.add_dependency(%q<httparty>, [">= 0"])
    end
  else
    s.add_dependency(%q<thoughtbot-shoulda>, [">= 0"])
    s.add_dependency(%q<httparty>, [">= 0"])
  end
end

