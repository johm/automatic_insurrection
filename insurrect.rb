require 'rubygems'
require 'haml'	
require 'sinatra'




class Wordlist
  attr_accessor :words
  
  def initialize(words)
    @words=words
  end
  
  def pick
    return "FAIL" if @words.size==0
    @words=@words.sort_by {rand}
    @words.pop
  end

end

class Wordlists
      attr_accessor :things_we_like,:things_we_dont_like,:things_we_do,:symbolic_things,:people_we_dont_like,:things_we_do,:our_things,:things_we_do_to_things,:things_we_dont_do,:describing_good_things,:describing_bad_things,:fancy_words,:how_we_do_things,:happiness,:sadness,:really,:making_things,:plans,:antiplans,:events,:fun_stuff,:dont_do,:get_along,:go_away,:preposition

      def initialize
        @things_we_like=Wordlist.new(["rupture","insurrection","crisis","social war","zones of indistinction which need no justification","indifference"])
        @things_we_dont_like=Wordlist.new(["activism","representation","humanism","totality","passivity","banality","fossilization of our desires","mobilization","impotentiality","normalization","absence"])
        @people_we_dont_like=Wordlist.new(["the milieu","liberalism","the bureaucrats of revolt","anarcho-liberalism"])
        @things_we_do=Wordlist.new(["desire","riot","occupy everything"])
        @our_things=Wordlist.new(["communes","multiplicities","encounters","becomings","zones of offensive capacity","desiring-bodies"])
        @symbolic_things=Wordlist.new(["burning dumpster","smashed window","moment of friendship","car set aflame","barricaded hallway"])
        @things_we_do_to_things=Wordlist.new(["destroy","shatter","negate","reject"])	    
        @things_we_dont_do=Wordlist.new(["organize","negotiate","make demands","be productive"])
        @how_we_do_things=Wordlist.new(["in secret","without illusions","for once and for all","absolutely"])
        @describing_good_things=Wordlist.new(["singular","immanent","inoperative","radical"])
        @describing_bad_things=Wordlist.new(["homogenous","pathetic","compulsive"])
        @fancy_words=Wordlist.new(["logic","structure","being","temporality","teleology"])
        @happiness=Wordlist.new(["joy","ecstasy"])
        @sadness=Wordlist.new(["misery","catastrophe"])
        @really=Wordlist.new(["by any means necessary","with every weapon at our disposal","without looking back","at all costs"])
        @making_things=Wordlist.new(["articulation","construction","elaboration","setting forth","realization"])
        @plans=Wordlist.new(["plan","project","concept"])
        @antiplans=Wordlist.new(["a <i>state of exception</i>","a <i>line of flight</i>","an <i>event</i>"])
        @events=Wordlist.new(["orgies","festivals","conspiracies"])
        @fun_stuff=Wordlist.new(["destruction","negation"])
        @get_along=Wordlist.new(["dialogue","criticism","sympathy"])
        @go_away=Wordlist.new(["scorn","contempt","derision"])
        @dont_do=Wordlist.new(["refuse","neglect","fail"])
        @preposition=Wordlist.new(["on","towards"])
      end
end

def recognize
  "Confronted with those who #{dont_do} to recognize themselves in our #{events} of #{fun_stuff}, we offer neither #{get_along} nor #{get_along} but only our #{go_away}."
end

def do_something
  "Our need to #{things_we_do} is less the #{making_things} of a #{plans} than the #{making_things} of #{antiplans}."
end

def in_the 
  "In the #{making_things} of #{our_things}, we #{things_we_do_to_things} those who would have us give up the #{describing_good_things} #{happiness} of #{things_we_like} for the #{sadness} of #{things_we_dont_like}."
end

def title
  "Leaving #{things_we_dont_like} behind: Notes #{preposition} #{things_we_like}"
end

def break_things
  "We must #{things_we_do_to_things} all #{things_we_dont_like}&#x2014;<i>#{how_we_do_things}</i>."
end

def this_call
  "This is a call to #{things_we_like}, not an insistence on #{things_we_dont_like}." 
end

def whats_needed
  "What's needed is not #{things_we_dont_like}, and even far less <i>#{things_we_dont_like}</i>, but a putting-into-practice of #{describing_good_things} #{things_we_like}, a rejection in all forms of the #{fancy_words} of #{things_we_dont_like}."
end

def every_what 
  "Every #{symbolic_things} is a refusal to #{things_we_dont_do}, a blow against the #{fancy_words} of #{people_we_dont_like}, a recognition of the #{describing_good_things} #{fancy_words} inherent in the articulation of #{our_things}."
end

def joke
  "The #{describing_bad_things} #{things_we_dont_like} proposed to us is like a bad joke, and instead of laughter we respond with #{things_we_like}."
end

def necessary
  "It is necessary to commence #{how_we_do_things}; not to dream of new ways to #{things_we_dont_do}, but to make manifest the subterranean #{our_things} in the heart of each #{symbolic_things}."
end

def symbols
  "To those who deride the #{describing_good_things} #{happiness} in a #{symbolic_things} or a #{symbolic_things}, we propose nothing less than to #{things_we_do_to_things} their #{describing_bad_things} #{things_we_dont_like}, #{really}."
end




def method_missing(methId)
  method_name=methId.id2name.intern
  if @lists.respond_to? method_name
    @lists.send(method_name).pick
  else
    method_name
  end
end

get '/stylesheet.css' do
    content_type 'text/css', :charset => 'utf-8'
    sass :stylesheet
end


get '/' do 
  @lists=Wordlists.new
  @title=title
  @sentences=[recognize,do_something,in_the,joke,break_things,this_call,whats_needed,every_what,necessary,symbols].sort_by {rand}
  @pull_quote=@sentences[0]
  @shuffled_sentences=@sentences.sort_by {rand}
  @babble=@shuffled_sentences[0,4].join(" ")
  @more_babble=@shuffled_sentences[4..7].join(" ")
  @even_more_babble=@shuffled_sentences[8..@shuffled_sentences.size].join(" ")
  haml :index
end




