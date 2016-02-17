# ruby objectOriented.rb english

require 'open-uri'

WORD_URL = "http://learncodethehardway.org/words.txt"
WORDS = []

PHRASES = {
  "class ### < ###\nend" =>
       "Make a class named ### that is-a ###.",
  "class ###\n\tdef initialize(@@@)\n\tend\nend" =>
       "class ### has-a initialize that takes @@@ parameters.",
  "class ###\n\tdef ***(@@@)\n\tend\nend" =>
       "class ### has-a function named *** that takes @@@ parameters.",
  "*** = ###.new()" =>
       "Set *** to an instance of class ###.",
  "***.***(@@@)" =>
       "From *** get the *** function, and call it with parameters @@@.",
  "***.*** = '***'" =>
       "From *** get the *** attribute and set it to '***'."
}

PHRASE_FIRST = ARGV[0] == "english"

open(WORD_URL) {|f|
  f.each_line {|word| WORDS.push(word.chomp)}
}

def craft_names(rand_words, snippet, pattern, caps=false)
  names = snippet.scan(pattern).map do
    word = rand_words.pop()
    caps ? word.capitalize : word
  end

  return names * 2
end

def craft_params(rand_words, snippet, pattern)
  names = (0...snippet.scan(pattern).length).map do
    param_count = rand(3) + 1
    params = (0...param_count).map {|x| rand_words.pop() }
    params.join(', ')
  end

  return names * 2
end

def convert(snippet, phrase)
  rand_words = WORDS.sort_by {rand}
  class_names = craft_names(rand_words, snippet, /###/, caps=true)
  other_names = craft_names(rand_words, snippet, /\*\*\*/)
  param_names = craft_params(rand_words, snippet, /@@@/)

  results = []

  [snippet, phrase].each do |sentence|
    # fake class names, also copies sentence
    result = sentence.gsub(/###/) {|x| class_names.pop }

    # fake other names
    result.gsub!(/\*\*\*/) {|x| other_names.pop }

    # fake parameter lists
    result.gsub!(/@@@/) {|x| param_names.pop }

    results.push(result)
  end

  return results
end

# keep going until they hit CTRL-D
loop do
  snippets = PHRASES.keys().sort_by {rand}

  for snippet in snippets
    phrase = PHRASES[snippet]
    question, answer = convert(snippet, phrase)

    if PHRASE_FIRST
      question, answer = answer, question
    end

    print question, "\n\n> "

    exit(0) unless $stdin.gets

    puts "\nANSWER:  %s\n\n" % answer
  end
end


=begin

In this exercise I'm going to teach you how to speak "object oriented." What I'll do is give you a small set of words with definitions you need to know. Then I'll give you a set of sentences with holes in them that you'll have to understand. Finally, I'm going to give you a large set of exercises that you have to complete to make these sentences solid in your vocabulary.

Word Drills
class
Tell Ruby to make a new type of thing.
object
Two meanings: the most basic type of thing, and any instance of some thing.
instance
What you get when you tell Ruby to create a class.
def
How you define a function inside a class.
@
Inside the functions in a class, @ is a variable for the instance/object being accessed.
inheritance
The concept that one class can inherit traits from another class, much like you and your parents.
composition
The concept that a class can be composed of other classes as parts, much like how a car has wheels.
attribute
A property classes have that are from composition and are usually variables.
is-a
A phrase to say that something inherits from another, as in a "salmon" is-a "fish."
has-a
A phrase to say that something is composed of other things or has a trait, as in "a salmon has-a mouth."
Take some time to make flash cards for these terms and memorize them. As usual this won't make too much sense until after you are finished with this exercise, but you need to know the base words first.

Phrase Drills
Next I have a list of Ruby code snippets on the left, and the English sentences for them:

class X(Y)
"Make a class named X that is-a Y."
class X(object): def initialize(J)
"class X has-a initialize that takes a J parameter."
class X(object): def M(J)
"class X has-a function named M that takes a J parameter."
foo = X()
"Set foo to an instance of class X."
foo.M(J)
"From foo get the M function, and call it with parameter J."
foo.K = Q
"From foo get the K attribute and set it to Q."
In each of these where you see X, Y, M, J, K, Q, and foo you can treat those like blank spots. For example, I can also write these sentences as follows:

"Make a class named ??? that is-a Y."
"class ??? has-a initialize that takes ??? parameters."
"class ??? has-a function named ??? that takes ??? parameters."
"Set foo to an instance of class ???."
"From foo get the ??? function, and call it with parameters ???."
"From foo get the ??? attribute and set it to ???."
Again, write these on some flash cards and drill them. Put the Ruby code snippet on the front and the sentence on the back. You have to be able to say the sentence exactly the same every time whenever you see that form. Not sort of the same, but exactly the same.

Combined Drills
The final preparation for you is to combine the words drills with the phrase drills. What I want you to do for this drill is this:

Take a phrase card and drill it.
Flip it over and read the sentence, and for each word in the sentence that is in your words drills, get that card.
Drill those words for that sentence.
Keep going until you are bored, then take a break and do it again.


=end
