source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


gem 'rails', '~> 5.1.3'
gem 'sqlite3'
gem 'pg', group: :production # Added postgres and made it production only.
gem 'rails_12factor' # Heroku gem to set deployment platform

gem 'puma', '~> 3.7'
gem 'bcrypt', '~> 3.1.7'
gem 'rack-cors'
gem 'active_model_serializers', '~> 0.10.0.rc1'
gem 'jwt'
gem 'rabl'
gem 'oj'

group :development do
  gem "better_errors"
  gem "binding_of_caller"
end

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
