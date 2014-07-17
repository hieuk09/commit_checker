Gem::Specification.new do |s|
  s.name        = 'commit_checker'
  s.version     = '0.0.1'
  s.date        = '2014-07-14'
  s.summary     = "Commit Checker"
  s.description = "A simple gem which help setup hook to check commit"
  s.authors     = ["Hieu Nguyen"]
  s.email       = 'hieu.nguyen@eastagile.com'
  s.files         = `git ls-files`.split($/)
  s.require_paths = ["lib"]
  s.homepage    = ''
  s.license       = 'MIT'
  s.add_dependency 'railties', '4.1.4'
  s.add_dependency 'rubocop', '0.24.1'
  s.add_dependency 'highline', '1.6.21'
end
