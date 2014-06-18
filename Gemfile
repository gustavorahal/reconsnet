source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.1'
gem 'pg'
gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'

gem 'therubyracer', platforms: :ruby
gem 'jquery-rails'

# UI/Web
gem 'bootstrap-sass', '~> 3.1.1'
gem 'bootstrap_form', :git => 'git://github.com/bootstrap-ruby/rails-bootstrap-forms', :branch => 'master'
gem 'kaminari' # will_paginate, rails 4.1 e pg_search não estavam funcionando bem juntos então a opção pelo kaminari
gem 'kaminari-bootstrap'

gem 'pry-rails', group: :development
gem 'annotate', group: :development

gem 'turbolinks'
gem 'jquery-turbolinks'

gem 'pundit'
gem 'devise'

# para manipulação de números de telefone
gem 'phony_rails'
# para manipulação de nomes de países e seus estados
gem 'carmen-rails', '~> 1.0.0'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :development, :test do
  gem 'rspec-rails'
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'factory_girl_rails'
  gem 'database_cleaner'
  gem 'poltergeist'
  gem 'capybara'
  gem 'launchy' # for save_and_open_page
  gem 'guard-rspec'
  gem 'rb-fsevent' if `uname` =~ /Darwin/ # para OS X
end

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.2'

