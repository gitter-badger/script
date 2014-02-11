#!/usr/bin/ruby -w
# canvas_i18n.rb
# Description: Canvas internationalization gem

require 'i18n'

## > Q: can I hook this up with PostgreSQL (i'll use ActiveRecord)

## Devise
# # Additional translations at https://github.com/plataformatec/devise/wiki/I18n
# en:
#   devise:
#     confirmations:
#       confirmed: "Your account was successfully confirmed. You are now signed in."
#       send_instructions: "You will receive an email with instructions about how to confirm your account in a few minutes."
#       send_paranoid_instructions: "If your email address exists in our database, you will receive an email with instructions about how to confirm your account in a few minutes."
#     failure:
#       already_authenticated: "You are already signed in."
#       inactive: "Your account was not activated yet."
#       invalid: "Invalid email or password."
#       invalid_token: "Invalid authentication token."
#       locked: "Your account is locked."
#       not_found_in_database: "Invalid email or password."
#       timeout: "Your session expired, please sign in again to continue."
#       unauthenticated: "You need to sign in or sign up before continuing."
#       unconfirmed: "You have to confirm your account before continuing."
#     mailer:
#       confirmation_instructions:
#         subject: "Confirmation instructions"
#       reset_password_instructions:
#         subject: "Reset password instructions"
#       unlock_instructions:
#         subject: "Unlock Instructions"
#     omniauth_callbacks:
#       failure: "Could not authenticate you from %{kind} because \"%{reason}\"."
#       success: "Successfully authenticated from %{kind} account."
#     passwords:
#       no_token: "You can't access this page without coming from a password reset email. If you do come from a password reset email, please make sure you used the full URL provided."
#       send_instructions: "You will receive an email with instructions about how to reset your password in a few minutes."
#       send_paranoid_instructions: "If your email address exists in our database, you will receive a password recovery link at your email address in a few minutes."
#       updated: "Your password was changed successfully. You are now signed in."
#       updated_not_active: "Your password was changed successfully."
#     registrations:
#       destroyed: "Bye! Your account was successfully cancelled. We hope to see you again soon."
#       signed_up: "Welcome! You have signed up successfully."
#       signed_up_but_inactive: "You have signed up successfully. However, we could not sign you in because your account is not yet activated."
#       signed_up_but_locked: "You have signed up successfully. However, we could not sign you in because your account is locked."
#       signed_up_but_unconfirmed: "A message with a confirmation link has been sent to your email address. Please open the link to activate your account."
#       update_needs_confirmation: "You updated your account successfully, but we need to verify your new email address. Please check your email and click on the confirm link to finalize confirming your new email address."
#       updated: "You updated your account successfully."
#     sessions:
#       signed_in: "Signed in successfully."
#       signed_out: "Signed out successfully."
#     unlocks:
#       send_instructions: "You will receive an email with instructions about how to unlock your account in a few minutes."
#       send_paranoid_instructions: "If your account exists, you will receive an email with instructions about how to unlock it in a few minutes."
#       unlocked: "Your account has been unlocked successfully. Please sign in to continue."
#   errors:
#     messages:
#       already_confirmed: "was already confirmed, please try signing in"
#       confirmation_period_expired: "needs to be confirmed within %{period}, please request a new one"
#       expired: "has expired, please request a new one"
#       not_found: "not found"
#       not_locked: "was not locked"
#       not_saved:
#         one: "1 error prohibited this %{resource} from being saved:"
#         other: "%{count} errors prohibited this %{resource} from being saved:"

## Formatting
# en:
#   hello: "Hello world"
## EXAMPLES
# https://github.com/svenfuchs/rails-i18n/tree/master/rails%2Flocale

## Rails usage
# To use the locales, use `I18n.t`:
#     I18n.t 'hello'
# In views, this is aliased to just `t`:
#     <%= t('hello') %>
# To use a different locale, set it with `I18n.locale`:
#     I18n.locale = :es
# This would use the information in config/locales/es.yml.

## ActiveModel::Name#i18n_key
  # attr_reader cache_key, attr_reader collection, attr_reader element,
  # attr_reader i18n_key, attr_reader name, attr_reader param_key, attr_reader
  # plural, attr_reader route_key, attr_reader singular, attr_reader
  # singular_route_key

## ActiveModel::Translation#i18n_scope
  # Provides integration between your object and the Rails internationalization
  # (i18n) framework.
  # A minimal implementation could be:
  #   class TranslatedPerson
  #     extend ActiveModel::Translation
  #   end
  #   TranslatedPerson.human_attribute_name('my_attribute')
  #   # => "My attribute"
  # This also provides the required class methods for hooking into the Rails
  # internationalization API, including being able to define a class based
  # i18n_scope and lookup_ancestors to find translations in parent classes.
  # ------------------------------------------------------------------------------
  # = Instance methods:
  #   human_attribute_name, i18n_scope, lookup_ancestors

## Gherkin::Lexer::I18nLexer#i18n_language
  # = Class methods:
  #   new
  # = Instance methods:
  #   create_delegate, i18n_language, lang, scan
  # = Attributes:
  #   attr_reader i18n_language
## Gherkin::Parser::Parser#i18n_language
  # = Class methods:
  #   new
  # = Instance methods:
  #   errors, event, expected, force_state, i18n_language, machine, parse,
  #   pop_machine, push_machine

## APPLICATIONS
# date and time
# language
# ageism (users < 21, 20-30, 31-40, etc...)
# acounts (visitor, employee, admin)

## REQUIRED -
# 1. specify locale dictionaries
# 2. specify how we switch locales

## DOCUMENTATION = I18n
# ------------------------------------------------------------------------------
# = Extended by:
# Module (from gem i18n-0.6.9)

# (from gem i18n-0.6.9)
# ------------------------------------------------------------------------------
# This module allows you to easily cache all responses from the backend - thus
# speeding up the I18n aspects of your application quite a bit.

# To enable caching you can simply include the Cache module to the Simple
# backend - or whatever other backend you are using:

#   I18n::Backend::Simple.send(:include, I18n::Backend::Cache)

# You will also need to set a cache store implementation that you want to use:

#   I18n.cache_store = ActiveSupport::Cache.lookup_store(:memory_store)

# You can use any cache implementation you want that provides the same API as
# ActiveSupport::Cache (only the methods #fetch and #write are being used).

# The cache_key implementation assumes that you only pass values to
# I18n.translate that return a valid key from #hash (see
# http://www.ruby-doc.org/core/classes/Object.html#M000337).

# If you use a lambda as a default value in your translation like this:# ------------------------------------------------------------------------------
# = Extended by:
# Module (from gem i18n-0.6.9)

# (from gem i18n-0.6.9)
# ------------------------------------------------------------------------------

# This module allows you to easily cache all responses from the backend - thus
# speeding up the I18n aspects of your application quite a bit.

# To enable caching you can simply include the Cache module to the Simple
# backend - or whatever other backend you are using:

#   I18n::Backend::Simple.send(:include, I18n::Backend::Cache)

# You will also need to set a cache store implementation that you want to use:

#   I18n.cache_store = ActiveSupport::Cache.lookup_store(:memory_store)

# You can use any cache implementation you want that provides the same API as
# ActiveSupport::Cache (only the methods #fetch and #write are being used).

# The cache_key implementation assumes that you only pass values to
# I18n.translate that return a valid key from #hash (see
# http://www.ruby-doc.org/core/classes/Object.html#M000337).

# If you use a lambda as a default value in your translation like this: