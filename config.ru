require 'roda'
require 'active_support/inflector'
require 'active_support/core_ext/integer/inflections'
require 'active_support/version'

class App < Roda

  BLACKLIST = [:inflections, :transliterate]
  INFLECTIONS = ActiveSupport::Inflector.instance_methods.sort.reject { |i| BLACKLIST.include?(i) }
  INDEXES = {
    :first_end => INFLECTIONS.length.odd? ? INFLECTIONS.length / 2 + 1 : INFLECTIONS.length / 2,
    :second_start => INFLECTIONS.length.odd? ? INFLECTIONS.length - INFLECTIONS.length / 2 - 1 : INFLECTIONS.length - INFLECTIONS.length / 2
  }

  plugin :render, :engine => 'slim'

  route do |r|

    r.root do
      @text = 'foo bar'
      render :index
    end

    r.on :all do |text|
      @raw = r.path[1..-1]
      @escaped = CGI.unescape(@raw)
      @text = @escaped.to_i.zero? ? @escaped : @escaped.to_i
      render :index
    end

  end

end

run App.freeze.app
