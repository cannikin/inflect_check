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
  DOCS = {
    :camelize => 'Converts strings to UpperCamelCase. Accepts a boolean argument and if set to `false` produces lowerCamelCase.',
    :classify => 'Creates a class name from a plural table name like Rails does for table names to models. Note that this returns a string and not a Class.',
    :constantize => 'Tries to find a constant with the name specified in the argument string.',
    :dasherize => 'Replaces underscores with dashes in the string.',
    :deconstantize => 'Removes the rightmost segment from the constant expression in the string.',
    :demodulize => 'Removes the module part from the expression in the string.',
    :foreign_key => 'Creates a foreign key name from a class name. separate_class_name_and_id_with_underscore sets whether the method should put \'_\' between the name and \'id\'.',
    :humanize => 'Tweaks an attribute name for display to end users: applies human inflection rules to the argument, deletes leading underscores (if any), removes a \'_id\' suffix if present, replaces underscores with spaces (if any), downcases all words except acronyms, capitalizes the first word.',
    :ordinal => 'Returns the suffix that should be added to a number to denote the position in an ordered sequence such as 1st, 2nd, 3rd, 4th.',
    :ordinalize => 'Turns a number into an ordinal string used to denote the position in an ordered sequence such as 1st, 2nd, 3rd, 4th.',
    :parameterize => 'Replaces special characters in a string so that it may be used as part of a \'pretty\' URL.',
    :pluralize => 'Returns the plural form of the word in the string.',
    :safe_constantize => 'Tries to find a constant with the name specified in the argument string. `nil` is returned when the name is not in CamelCase or the constant (or part of it) is unknown.',
    :singularize => 'The reverse of pluralize, returns the singular form of a word in a string.',
    :tableize => 'Creates the name of a table like Rails does for models to table names. This method uses the pluralize method on the last word in the string.',
    :titleize => 'Capitalizes all the words and replaces some characters in the string to create a nicer looking title. titleize is meant for creating pretty output.',
    :underscore => 'Makes an underscored, lowercase form from the expression in the string.',
    :upcase_first => 'Converts just the first character to uppercase.'
  }

  plugin :render, :engine => 'slim'
  plugin :partials, :views => 'views'
  plugin :public

  route do |r|

    @path = r.path[1..-1]
    @raw = @path.empty? ? 'foo_bar' : @path
    @escaped = CGI.unescape(@raw)
    @text = @escaped.to_i.zero? ? @escaped : @escaped.to_i

    r.public

    r.root do
      view :index
    end

    r.on :all do |text|
      view :index
    end

  end

end

run App.freeze.app
