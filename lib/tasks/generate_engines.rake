task :generate_engine do
  # Get name sent from console
  name = ENV['name'].downcase

  # Store useful paths
  engine_path         = "engines/#{name}"
  dummy_path          = 'spec/dummy'
  lib_files_path      = 'lib/tasks/files'
  dummy_relative_path = "#{engine_path}/#{dummy_path}"

  # Generate the new mountable engine with a dummy under 'spec/dummy' path
  sh "rails plugin new #{engine_path} --mountable --skip-test --dummy-path=#{dummy_path}"

  dummy_folders_to_remove = %w[app bin lib storage public log tmp]
  dummy_files_to_remove = %w[package.json Rakefile]

  dummy_folders_paths = dummy_folders_to_remove.map { |folder|
    "#{dummy_relative_path}/#{folder}"
  }.join(' ')

  dummy_files_paths = dummy_files_to_remove.map { |file|
    "#{dummy_relative_path}/#{file}"
  }.join(' ')

  # We copy the Gemfile, Rakefile and Gemspec files from our files folder to the engine
  puts '------Copying rails files------'
  sh "yes | cp #{lib_files_path}/generic.gemspec #{engine_path}/#{name}.gemspec"
  sh "yes | cp #{lib_files_path}/Gemfile #{engine_path}"
  sh "yes | cp #{lib_files_path}/Rakefile #{engine_path}"
  sh "yes | cp #{lib_files_path}/lib/engine/engine.rb #{engine_path}/lib/#{name}/engine.rb"

  # Copy our rake tasks for the engine
  puts '------Copying rake tasks------'
  sh "yes | cp #{lib_files_path}/lib/tasks/install_rspec.rake #{engine_path}/lib/tasks"

  # We replace "EngineName" place holder with the correct engine name
  puts '------Adapting system files------'
  sh "sed -i '' 's/EngineName/#{name.classify}/g' #{engine_path}/Rakefile"
  sh "sed -i '' 's/EngineName/#{name}/g' #{engine_path}/Gemfile"
  sh "sed -i '' 's/ClassifiedEngineName/#{name.classify}/g' #{engine_path}/#{name}.gemspec"
  sh "sed -i '' 's/EngineName/#{name}/g' #{engine_path}/#{name}.gemspec"
  sh "sed -i '' 's/ClassifiedEngineName/#{name.classify}/g' #{engine_path}/lib/#{name}/engine.rb"

  # Install
  puts '------Installing gemfile and rspec------'
  sh "BUNDLE_GEMFILE=#{engine_path}/Gemfile bundle install"
  sh "cd #{engine_path} && rake install_rspec"

  # We remove unnecessary files
  puts '------Removing unnecessary files------'
  sh "rm -rf #{dummy_folders_paths}"
  sh "rm #{dummy_files_paths}"

  puts '------Copying rspec helpers------'
  sh "yes | cp #{lib_files_path}/spec/spec_helper.rb #{engine_path}/spec"
  sh "yes | cp #{lib_files_path}/spec/rails_helper.rb #{engine_path}/spec"
  sh "yes | cp #{lib_files_path}/spec/helpers.rb #{engine_path}/spec"

  puts '------Adapting helper files------'
  sh "sed -i '' 's/ClassifiedEngineName/#{name.classify}/g' #{engine_path}/spec/helpers.rb"

  puts '------Engine generated successfully------'
end