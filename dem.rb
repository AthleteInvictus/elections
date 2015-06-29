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

difference = (sanders[:value] - clinton[:value]).to_f
firstpart = (difference/3).to_f
tdist = (Statistics2.tdist(2,firstpart)).to_f
tdistabs = (Statistics2.tdist(2,firstpart.abs)).to_f
percent = tdist*100
percentabs = tdistabs*100
opercent = (1-tdist)*100
opercentabs = (1-tdistabs)*100

case 
  when difference < 0
    puts "#{100-opercentabs.round(2)}""%" " Clinton."
    puts "#{opercentabs.round(2)}""%" " Sanders."
    puts "Based on latest poll at Pollster.com"
  when difference > 0
    puts "#{(percentabs.round(2))}""%" " Clinton."
    puts "#{(opercentabs.round(2))}""%" " Sanders."
    puts "Based on latest poll at Pollster.com"
  else 
	puts "An error occurred."
	puts "Seek help at:"
	puts "github.com/AthleteInvictus"
  end

runcsv = File.open("csv/gop.csv", "w+")
  runcsv.puts (opercent.round(2)).abs
  runcsv.puts "Sanders"
  runcsv.puts (percent.round(2)).abs
  runcsv.puts "Clinton"
