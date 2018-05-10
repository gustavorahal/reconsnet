source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.0'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'

gem 'therubyracer', platforms: :ruby
gem 'jquery-rails'
gem 'aws-sdk-s3', require: false

# UI/Web
gem 'bootstrap-sass', '~> 3.3.6'
gem 'font-awesome-rails'
gem 'autoprefixer-rails', '>= 5.2.1' # recommended for bootstrap-sass
gem 'bootstrap_form'
gem 'mini_magick' # for activestorage to create variation of a image
gem 'tinymce-rails'
gem 'tinymce-rails-langs'
gem 'tinymce-rails-imageupload', '~> 4.0.0.beta'
gem 'kaminari' # will_paginate, rails 4.1 e pg_search não estavam funcionando bem juntos então a opção pelo kaminari
gem 'kaminari-bootstrap'

gem 'turbolinks', '~> 5'
gem 'jquery-turbolinks'
gem 'holder_rails'

gem 'pundit'
gem 'rolify'
gem 'devise'
gem 'paperclip', '~> 6.0.0'
gem 'paper_trail'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

# mailchimp api wrapper
gem 'gibbon'

# Para geração de arquivos em PDF
gem 'prawn'
gem 'prawn-table'

# Executor de jobs em 2o plano
gem 'sidekiq'
gem 'sinatra', :require => nil # para web do sidekiq

# para manipulação de números de telefone
gem 'phony_rails'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capybara'
  gem 'database_cleaner'
  gem 'factory_girl_rails'
  gem 'launchy' # for save_and_open_page
  gem 'poltergeist'
  gem 'rspec-rails'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'listen', '~> 3.0.5'
  gem 'annotate'
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]