# cat hello_world.rb
require "cuba"
require "cuba/safe"
require 'erb'

x = 42
template = ERB.new <<-EOF
  The value of x is: <%= x %>
EOF

Cuba.use Rack::Session::Cookie, :secret => "__a_very_long_string__"

Cuba.plugin Cuba::Safe

Cuba.define do
  
  c1 = Mc1.new(res,req)
  c2 = Mc2.new(res,req)
  c3 = Mc3.new(res,req)

  on get do

  	#c1.out()

    on "hello" do 
    	res.write "Hello world!"
    end

    on root do
      res.redirect "/hello"
    end

    on "tpl" do
    	res.write template.result(binding)
    end

    # /about
    on "about" do
      res.write "About"
    end
    # /search?q=difficultquestion
    on "things/search", param("q") do |query|
      res.write "Searched for #{query}" #=> "Searched for difficultquestion"
    end

  end
end

class Mc
   def initialize(res,req)
   		@res = res
   		@req = req
   end
end

class Mc1 < Mc
	def out()
		@res.write "111"
	end
end

class Mc2 < Mc
	def out()
		@res.write "222"
	end
end

class Mc3 < Mc
	def out()
		@res.write "333"
	end
end

