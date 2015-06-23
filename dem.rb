require 'csv'
require 'statistics2'
require 'pollster'
require 'uri'
include Pollster

poll = Poll.where(:chart => '2016-national-democratic-primary').first
responses = poll.questions.detect { |question| question.chart == '2016-national-democratic-primary' }.responses
clinton = responses.detect { |response| response[:choice] == "Clinton" }
sanders = responses.detect { |response| response[:choice] == "Sanders" }
biden = responses.detect { |response| response[:choice] == "Biden" }
omalley = responses.detect { |response| response[:choice] == "O'Malley" }
webb = responses.detect { |response| response[:choice] == "Webb" }

difference = clinton[:value] - sanders[:value]
negativechance = Statistics2.tdist(2,(difference/3)) 
nchance = 1 - (Statistics2.tdist(2,(difference/3)))

if difference < 0
then puts "#{nchance.to_f*100}""%" + " Sanders."
	 puts "#{(1-nchance.to_f)*100}""%" + " Clinton."
	 puts "Based on latest poll at Pollster.com"
else puts "#{negativechance.to_f*100}""%" " Clinton."
	 puts "#{(1-negativechance.to_f)*100}""%" + " Sanders."
	 puts "Based on latest poll at Pollster.com"
end


