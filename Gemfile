source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.6.4"

# Defaults stuff than usually com with a new rails app
gem 'rails', '~> 6.0.1'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 4.1'
gem 'sass-rails', '>= 6'
gem 'webpacker', '~> 4.0'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.7'
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'
gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

gem 'jquery-rails'
gem 'aws-sdk-s3', require: false

# UI/Web
gem 'bootstrap', '~> 4.4.1'
gem 'bootstrap_form', '>= 4.3.0'
gem 'font-awesome-rails'
gem 'mini_magick' # for activestorage to create variation of a image
gem 'tinymce-rails'
gem 'tinymce-rails-langs'
gem 'kaminari' # will_paginate, rails 4.1 e pg_search não estavam funcionando bem juntos então a opção pelo kaminari

gem 'jquery-turbolinks'
gem 'holder_rails'

gem 'pundit'
gem 'rolify'
gem 'devise'
gem 'paper_trail'

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


group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'annotate'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'launchy' # for save_and_open_page
  gem 'webdrivers'
  gem 'poltergeist'
  gem 'rspec-rails'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
