source 'https://rubygems.org'

ruby "2.2.1"

gem 'rails', '4.2.1'
gem 'mysql2'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
# gem 'therubyracer', platforms: :ruby
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'haml'

gem 'unicorn'

gem 'devise'
gem 'cancan'
gem 'cancan_strong_parameters', '~> 0.4'

gem 'bootstrap-sass', '3.2.0.2'
gem 'autoprefixer-rails'

gem "paperclip", "~> 4.2"
# gem 'bootstrap-datepicker-rails'
# gem 'bootstrap-datetimepicker-rails'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :production do
  # gem 'mysql2', '~> 0.3'
  gem 'therubyracer'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Access an IRB console on exception pages or by using <%= console %> in views
  # gem 'web-console', '~> 2.0'

  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'haml-rails'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end
