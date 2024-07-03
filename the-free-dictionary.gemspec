# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name        = 'the-free-dictionary'
  s.version     = '0.0.3'
  s.summary     = 'TheFreeDictionary is a gem that fetches information about words from https://www.thefreedictionary.com/'
  s.authors     = ['Anatoly Busygin']
  s.email       = 'anatolyb94@gmail.com'
  s.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  s.homepage =
    'https://github.com/Suban05/the-free-dictionary'
  s.license = 'MIT'
  s.metadata = {
    "homepage_uri" => s.homepage,
    "source_code_uri" => 'https://github.com/Suban05/the-free-dictionary',
    "bug_tracker_uri" => 'https://github.com/Suban05/the-free-dictionary/issues'
  }
end
