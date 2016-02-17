=begin


Modules Are Like Hashes
You know how a hash is created and used and that it is a way to map one thing to another. That means if you have a hash with a key "apple" and you want to get it then you do this:

mystuff = {'apple' => "I AM APPLES!"}
puts mystuff['apple']
Keep this idea of "get X from Y" in your head, and now think about modules. You've made a few so far, and you should know they are:

A Ruby file with some functions or variables in it inside a module .. end block..
You import that file.
And you can access the functions or variables in that module with the . (dot) operator.
Imagine I have a module that I decide to name mystuff.rb and I put a function in it called apple. Here's the module mystuff.rb:

# this goes in mystuff.rb
module MyStuff
    def MyStuff.apple()
        puts "I AM APPLES!"
    end
end
Once I have this code, I can use the module MyStuff with require and then access the apple function:

require "./mystuff.rb"
MyStuff.apple()
I could also put a variable in it named tangerine:

module MyStuff
    def MyStuff.apple()
        puts "I AM APPLES!"
    end

    # this is just a variable
    TANGERINE = "Living reflection of a dream"
end
I can access that the same way:

MyStuff.apple()
puts MyStuff::TANGERINE
Refer back to the hash, and you should start to see how this is similar to using a hash, but the syntax is different. Let's compare:

mystuff['apple'] # get apple from dict
MyStuff.apple() # get apple from the module
MyStuff::TANGERINE # same thing, it's just a variable
This means we have a very common pattern in Ruby:

Take a key=value style container.
Get something out of it by the key's name.
In the case of the hash, the key is a string and the syntax is [key]. In the case of the module, the key is an identifier, and the syntax is .key. Other than that they are nearly the same thing.


=end




=begin

thing = MyStuff.new()
thing.apple()
puts thing.tangerine

=end


=begin

Classes Are Like Modules
You can think about a module as a specialized hash that can store Ruby code so you can access it with the . operator. Ruby also has another construct that serves a similar purpose called a class. A class is a way to take a grouping of functions and data and place them inside a container so you can access them with the . (dot) operator.



class MyStuff

    def initialize()
        @tangerine = "And now a thousand years between"
    end

    attr_reader :tangerine

    def apple()
        puts "I AM CLASSY APPLES!"
    end

end


That looks complicated compared to modules, and there is definitely a lot going on by comparison, but you should be able to make out how this is like a "mini-module" with MyStuff having an apple() function in it. What is probably confusing is the initialize() function and use of @tangerine for setting the tangerine instance variable.

Here's why classes are used instead of modules: You can take this MyStuff class and use it to craft many of them, millions at a time if you want, and each one won't interfere with each other. When you import a module there is only one for the entire program unless you do some monster hacks.

Before you can understand this though, you need to know what an "object" is and how to work with MyStuff just like you do with the mystuff.rb module.



=end

class Song

  def initialize(lyrics)
    @lyrics = lyrics
  end

  def sing_me_a_song()
    @lyrics.each {|line| puts line }
  end
end

happy_bday = Song.new(["Happy birthday to you",
           "I don't want to get sued",
           "So I'll stop right there"])

bulls_on_parade = Song.new(["They rally around tha family",
            "With pockets full of shells"])

happy_bday.sing_me_a_song()

bulls_on_parade.sing_me_a_song()
