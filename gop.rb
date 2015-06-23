require 'csv'
require 'statistics2'
require 'pollster'
require 'uri'
include Pollster

poll = Poll.where(:chart => '2016-national-gop-primary').first
responses = poll.questions.detect { |question| question.chart == '2016-national-gop-primary' }.responses
rubio = responses.detect { |response| response[:choice] == "Rubio" }
bush = responses.detect { |response| response[:choice] == "Bush" }
walker = responses.detect { |response| response[:choice] == "Walker" }
carson = responses.detect { |response| response[:choice] == "Carson" }
huckabee = responses.detect { |response| response[:choice] == "Huckabee" }
paul = responses.detect { |response| response[:choice] == "Paul" }
cruz = responses.detect { |response| response[:choice] == "Cruz" }

difference = rubio[:value] - walker[:value]
negativechance = Statistics2.tdist(2,(difference/3)) 
nchance = 1 - (Statistics2.tdist(2,(difference/3)))

if difference < 0
then puts "#{nchance.to_f*100}""%" + " Walker."
	 puts "#{(1-nchance.to_f)*100}""%" + " Rubio."
	 puts "Based on latest poll at Pollster.com"
else puts "#{negativechance.to_f*100}}""%" "Rubio."
	 puts "#{(1-negativechance.to_f)*100}""%" + " Walker."
	 puts "Based on latest poll at Pollster.com"
end





    
