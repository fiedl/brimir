source 'https://rubygems.org'

gem 'rails', '~> 5.0.0'

gem 'unicorn'

gem 'sass-rails', "~> 5.0.0"
gem 'coffee-rails', "~> 4.2.0"

gem 'uglifier', "~> 3.0.0"

gem 'compass-rails', '~> 3.0.0'
gem 'foundation-rails', '~> 5.5.0'

gem 'jquery-rails', "~> 4.2"
gem 'jquery-visibility-rails'

# foundation form errors
gem 'foundation_rails_helper', "~> 2.0"

# to use debugger
gem 'byebug', "~> 9.0", group: [:development, :test]
gem 'pry', "~> 0.10", group: [:development, :test]
gem 'pry-remote', group: [:development]

# We need this to not break the test suite as `assigns` and `assert_template` have been remove and extracted to a gem in Rails 5
gem 'rails-controller-testing', group: [:test]


group :development do
  # Spring application pre-loader
  gem 'spring', "~> 2.0"

  # open sent emails in the browser
  gem 'letter_opener', "~> 1.4"
end

group :test do
  # for travis-ci
  gem 'rake', "~> 12.0"

  # for coveralls
  gem 'coveralls', "~> 0.8"

  gem 'timecop', "~> 0.8"
end

# Optional PostgreSQL for production
#gem 'pg', group: :postgresql
# Optional MySQL for production
gem 'mysql2', group: :production
# Optional SQLite for development
gem 'sqlite3', group: [:development, :test]

# authentication
gem 'devise', "~> 4.2"
gem 'devise_ldap_authenticatable', "~> 0.8"

# mail see https://github.com/mikel/mail/issues/912
gem 'mail', '~> 2.6.6.rc1'

# omniauth
gem 'omniauth-google-oauth2', "~> 0.4"

# authorization
gem 'cancancan', "~> 1.15"

# pagination
gem 'will_paginate', "~> 3.1"

# attachments, thumbnails etc
gem 'paperclip', "~> 5.1"

# select2 replacement for selectboxes
gem 'select2-rails', '~> 3.5' # newer breaks Foundation Reveal on tickets#show

gem 'font-awesome-rails', '~> 4.0'

# for language detection
gem 'http_accept_language', "~> 2.1"

# internationalisation
gem 'rails-i18n', "~> 5.0"
gem 'devise-i18n', "~> 1.1"

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.6'

# fancybox for showing image in lightbox
gem 'fancybox2-rails', "~> 0.2"

# gravatar for user avatar images
gem 'gravatar_image_tag', "~> 1.2"

# Captcha for brimir
gem 'recaptcha', "~> 4.0", require: 'recaptcha/rails'

# Trix WYSIWYG editor
gem 'trix', "~> 0.10", ">= 0.10.1"

# React support
gem 'react-rails', "~> 1.10"

# Capistrano for deployment
group :development do
  gem 'capistrano', '~> 3.8'
  gem 'capistrano-rails', require: false
  gem 'capistrano-bundler', require: false
end

# bring back auto_link
gem 'rinku', require: 'rails_rinku'

# parse emails
gem 'extended_email_reply_parser', '>= 0.5.1' # github: 'fiedl/extended_email_reply_parser'

# exception notification via email
gem 'exception_notification'

gem 'nokogiri', '>= 1.8.1'