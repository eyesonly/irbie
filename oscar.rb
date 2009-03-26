require 'yaml'

class Oscar

  attr_accessor :next_oscar

  def initialize(filename, quotehour)
    @oscar =  YAML::load(File.open(filename))

    # Initialise the next time a quote should be said
    @next_oscar = Time.now.change(:hour => quotehour)
    @next_oscar = @next_oscar.tomorrow if @next_oscar < Time.now
  end

  def quote_oscar(st)
    st.lstrip!
    st = $1 if (/\/(.+?)\/(.*?)/).match(st)
    re = Regexp.new(st, Regexp::IGNORECASE)
    found = @oscar.find_all{ |e| e =~ re  }
    return ( '"' + found[rand(found.size)] + '" - Oscar Wilde')  if ! found.empty?
    return "Sorry, no Oscar Wilde quote found for #{st}" if found.empty?
  end
end
