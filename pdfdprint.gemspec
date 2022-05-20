lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pdfdprint/version'

Gem::Specification.new do |spec|
  spec.name        = 'pdfdprint'
  spec.version     = PDFDirectPrint::VERSION
  spec.authors     = ['Marc']
  spec.email       = ['hello@towards.ch']
  spec.summary     = 'Print PDF document directly to network-enabled printer'
  spec.description = 'Use raw printing functionality of network-enabled printer to print PDF files on port 9100/tcp.'
  spec.homepage    = 'https://towards.ch'
  spec.license     = 'GPL-3.0'
  spec.bindir      = 'exe'
  spec.files       = Dir['{bin,lib}/**/*', 'CHANGELOG.md', 'LICENSE', 'README.md']
  spec.executables << 'pdfdprint'

  spec.required_ruby_version = '>= 2.6'

  spec.metadata = {
    'allowed_push_host' => 'https://rubygems.org',
    'bug_tracker_uri' => 'https://github.com/towards/pdfdprint/issues',
    'changelog_uri' => 'https://github.com/towards/pdfdprint/blob/master/CHANGELOG.md',
    'documentation_uri' => 'https://www.rubydoc.info/gems/pdfdprint',
    'homepage_uri' => spec.homepage,
    'rubygems_mfa_required' => 'true',
    'source_code_uri' => 'https://github.com/towards/pdfdprint'
  }

  spec.add_development_dependency 'bundler', '~> 2.3'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rubocop', '~> 1.29'
end
