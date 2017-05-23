require 'roda'
require 'active_support/inflector'
require 'active_support/version'

class App < Roda

  plugin :render, :engine => 'slim'

  route do |r|

    @inflections = ActiveSupport::Inflector.instance_methods.sort

    r.root do
      @text = 'foo bar'
      render :index
    end

    r.on :all do |text|
      puts r.path
      @text = CGI.unescape(r.path[1..-1])
      render :index
    end

    # r.get :text do |text|
    #   puts r.path
    #   @text = CGI.unescape(text)
    #   render 'index'
    # end

  end

end

run App.freeze.app
