# frozen_string_literal: true

require_relative 'lib/covid19/version'

Gem::Specification.new do |spec|
  spec.name          = 'covid19'
  spec.version       = Covid19::VERSION
  spec.authors       = ['Valentin Kopotchel']
  spec.email         = ['valentin.kopotchel@cybergizer.com']

  spec.summary       = 'Ruby wrapper for COVID19-Data API'
  spec.homepage      = 'https://github.com/valkovik15/covid19'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.3.0')

  spec.metadata['allowed_push_host'] = "https://github.com"

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/valkovik15/covid19'
  spec.metadata['changelog_uri'] = 'https://github.com/valkovik15/covid19'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
end
