require 'roda'
require 'active_support/inflector'
require 'active_support/version'

class App < Roda

  plugin :render, :engine => 'slim'

  route do |r|

    @inflections = ActiveSupport::Inflector.instance_methods.sort

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
