begin

  require 'bundler/gem_tasks'

  def specs(dir)
    FileList["spec/#{dir}/*_spec.rb"].shuffle.join(' ')
  end

  desc "Runs all the specs"
  task :specs do
    sh "bundle exec bacon #{specs('**')}"
  end

  task :default => :specs

rescue LoadError
    $stderr.puts "\033[0;31m" \
      "[!] Please install the bundler gem manually:\n" \
      '    $ [sudo] gem install bundler' \
      "\e[0m"
end
