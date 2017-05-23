require 'roda'
require 'active_support/inflector'

class App < Roda

  plugin :render, :engine => :slim

  route do |r|

    @inflections1 = %w[camelize classify constantize dasherize deconstantize
      demodulize foreign_key humanize inflections ordinal]
    @inflections2 = %w[ordinalize parameterize pluralize safe_constantize
      singularize tableize titleize transliterate underscore upcase_first]

    r.root do
      @text = 'foo bar'
      render 'index'
    end

    r.get :text do |text|
      @text = CGI.unescape(text)
      render 'index'
    end

  end

end

run App.freeze.app
