require 'csv'
require 'statistics2'
require 'pollster'
require 'uri'
include Pollster

poll = Poll.where(:chart => '2016-iowa-presidential-republican-primary').first
responses = poll.questions.detect { |question| question.chart == '2016-iowa-presidential-republican-primary' }.responses
rubio = responses.detect { |response| response[:choice] == "Rubio" }
bush = responses.detect { |response| response[:choice] == "Bush" }
walker = responses.detect { |response| response[:choice] == "Walker" }
carson = responses.detect { |response| response[:choice] == "Carson" }
trump = responses.detect { |response| response[:choice] == "Trump" }

difference = bush[:value] - walker[:value].to_f
firstpart = (difference/3).to_f
tdist = (Statistics2.tdist(2,firstpart)).to_f
tdistabs = (Statistics2.tdist(2,firstpart.abs)).to_f
percent = tdist*100
percentabs = tdistabs*100
opercent = (1-tdist)*100
opercentabs = (1-tdistabs)*100

case 
  when difference < 0
    puts "Chances of winning Iowa GOP:"
    puts "#{opercentabs.round(2)}""%" " Bush."
    puts "#{100-opercentabs.round(2)}""%" " Walker."
    puts "Based on latest poll at Pollster.com"
  when difference > 0
    puts "Chances of winning Iowa GOP:"
    puts "#{(percentabs.round(2))}""%" " Walker."
    puts "#{(opercentabs.round(2))}""%" " Bush."
    puts "Based on latest poll at Pollster.com"
  else 
	puts "An error occurred."
	puts "Seek help at:"
	puts "github.com/AthleteInvictus"
  end

runcsv = File.open("csv/iowagop.csv", "w+")
  runcsv.puts (opercent.round(2)).abs
  runcsv.puts "Walker"
  runcsv.puts (percent.round(2)).abs
  runcsv.puts "Bush"

