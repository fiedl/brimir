source 'https://rubygems.org'

gem 'rails', '~> 4.2.0'

gem 'unicorn'

gem 'sass-rails', '~> 5.0.0'
gem 'coffee-rails', '~> 4.1.0'

gem 'uglifier', '>= 1.0.3'

gem 'compass-rails', '~> 2.0.0'
gem 'foundation-rails', '~> 5.5.0'

gem 'jquery-rails'

# foundation form errors
gem 'foundation_rails_helper'

# to use debugger
gem 'byebug', group: [:development, :test]
gem 'pry', group: [:development, :test]

group :development do
  # Spring application pre-loader
  gem 'spring'

  # open sent emails in the browser
  gem 'letter_opener'
end

group :test do
  # for travis-ci
  gem 'rake'

  # for coveralls
  gem 'coveralls'
end

# Optional PostgreSQL for production
#gem 'pg', group: :postgresql
# Optional MySQL for production
gem 'mysql2', group: :production
# Optional SQLite for development
gem 'sqlite3', group: [:development, :test]

# authentication
gem 'devise'
gem 'devise_ldap_authenticatable'

# omniauth
gem 'omniauth-google-oauth2'

# authorization
gem 'cancancan'

# pagination
gem 'will_paginate'

# attachments, thumbnails etc
gem 'paperclip'

# select2 replacement for selectboxes
gem 'select2-rails', '~> 3.5' # newer breaks Foundation Reveal on tickets#show

gem 'font-awesome-rails', '~> 4.0'

# TinyMCE 4 for WYSIWYG in textareas
gem 'tinymce-rails'

# for language detection
gem 'http_accept_language'

# internationalisation
gem 'rails-i18n'
gem 'devise-i18n'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.2'

# time traveling
gem 'timecop'

# fancybox for showing image in lightbox
gem 'fancybox2-rails', '~> 0.2.8'

# gravatar for user avatar images
gem 'gravatar_image_tag'

# bring back auto_link
gem 'rinku', require: 'rails_rinku'

# parse emails
gem 'extended_email_reply_parser', '>= 0.4.0' # github: 'fiedl/extended_email_reply_parser'

# exception notification via email
gem 'exception_notification'
