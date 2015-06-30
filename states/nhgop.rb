require 'csv'
require 'statistics2'
require 'pollster'
require 'uri'
include Pollster

puts "Enter a name:"
puts "Options are Rubio, Bush, Walker, Carson, Trump"
answer = gets.chomp
puts "Enter another name, same options:"
answer2 = gets.chomp

poll = Poll.where(:chart => '2016-new-hampshire-presidential-republican-caucus').first
responses = poll.questions.detect { |question| question.chart == '2016-new-hampshire-presidential-republican-caucus' }.responses
dude = responses.detect { |response| response[:choice] == "#{answer}" }
dude2 = responses.detect { |response| response[:choice] == "#{answer2}" }

difference = (dude[:value] - dude2[:value]).to_f
firstpart = (difference/3).to_f
tdist = (Statistics2.tdist(2,firstpart)).to_f
tdistabs = (Statistics2.tdist(2,firstpart.abs)).to_f
percent = tdist*100
percentabs = tdistabs*100
opercent = (1-tdist)*100
opercentabs = (1-tdistabs)*100

case 
  when difference < 0
    puts " "
    puts "#{opercentabs.round(2)}""%" " #{answer}."
    puts "#{100-opercentabs.round(2)}""%" " #{answer2}."
    puts "Based on latest poll at Pollster.com"
  when difference > 0
    puts " "
    puts "#{(opercentabs.round(2))}""%" " #{answer2}."
    puts "#{(percentabs.round(2))}""%" " #{answer}."
    puts "Based on latest poll at Pollster.com"
  when difference = 0
    puts "50% #{answer}."
    puts "50% #{answer2}."
    puts "Based on latest poll at Pollster.com"
  else 
	puts "An error occurred."
	puts "Seek help at:"
	puts "github.com/AthleteInvictus"
  end

CSV.open("csv/nhgop.csv", "w") do |csv|
 csv << [answer, answer2]
 csv << [percent.round(2).abs, opercent.round(2).abs]
end
