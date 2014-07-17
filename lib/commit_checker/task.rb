require 'rails/railtie'

module CommitChecker
  class Task < ::Rails::Railtie
    railtie_name :commit_checker

    rake_tasks do
      Dir[File.join(File.dirname(__FILE__), 'tasks/*.rake')].each { |f| load f }
    end
  end
end
