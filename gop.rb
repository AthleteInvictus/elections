require 'csv'
require 'statistics2'
require 'pollster'
require 'uri'
include Pollster


puts "Enter a name:"
puts "Options are Jeb Bush, Trump, Carson, Walker, Rubio"
answer = gets.chomp

poll = Poll.where(:chart => '2016-national-gop-primary').first
responses = poll.questions.detect { |question| question.chart == '2016-national-gop-primary' }.responses
dude = responses.detect { |response| response[:choice] == "#{answer}" }
bush = responses.detect { |response| response[:choice] == "Jeb Bush" }
trump = responses.detect { |response| response[:choice] == "Trump" }
carson = responses.detect { |response| response[:choice] == "Carson" }
walker = responses.detect { |response| response[:choice] == "Walker" }
rubio = responses.detect { |response| response[:choice] == "Rubio" }

difference1 = (dude[:value] - trump[:value]).to_f
firstpart1 = (difference1/3).to_f
tdist1 = (Statistics2.tdist(2,firstpart1)).to_f
tdistabs1 = (Statistics2.tdist(2,firstpart1.abs)).to_f
percent1 = tdist1
percentabs1 = tdistabs1
opercent1 = (1-tdist1)
opercentabs1 = (1-tdistabs1)
case 
  when difference1 < 0
  use1 = opercentabs1.round(2)
  when difference1 > 0
  use1 = percentabs1.round(2)
  when difference1 = 0
  use1 = 0.5
  else 
  puts "Nothing"
end

difference2 = (dude[:value] - bush[:value]).to_f
firstpart2 = (difference2/3).to_f
tdist2 = (Statistics2.tdist(2,firstpart2)).to_f
tdistabs2 = (Statistics2.tdist(2,firstpart2.abs)).to_f
percent2 = tdist2
percentabs2 = tdistabs2
opercent2 = (1-tdist2)
opercentabs2 = (1-tdistabs2)
case 
  when difference2 < 0
  use2 = opercentabs2.round(2)
  when difference2 > 0
  use2 = percentabs2.round(2)
  when difference2 = 0
  use2 = 0.5
  else 
  puts "Nothing"
end

difference3 = (dude[:value] - carson[:value]).to_f
firstpart3 = (difference3/3).to_f
tdist3 = (Statistics2.tdist(2,firstpart3)).to_f
tdistabs3 = (Statistics2.tdist(2,firstpart3.abs)).to_f
percent3 = tdist3
percentabs3 = tdistabs3
opercent3 = (1-tdist3)
opercentabs3 = (1-tdistabs3)
case 
  when difference3 < 0
  use3 = opercentabs3.round(2)
  when difference3 > 0
  use3 = percentabs3.round(2)
  when difference3 = 0
  use3 = 0.5
  else 
  puts "Nothing"
end

difference4 = (dude[:value] - walker[:value]).to_f
firstpart4 = (difference4/3).to_f
tdist4 = (Statistics2.tdist(2,firstpart4)).to_f
tdistabs4 = (Statistics2.tdist(2,firstpart4.abs)).to_f
percent4 = tdist4
percentabs4 = tdistabs4
opercent4 = (1-tdist4)
opercentabs4 = (1-tdistabs4)
case 
  when difference4 < 0
  use4 = opercentabs4.round(2)
  when difference4 > 0
  use4 = percentabs4.round(2)
  when difference4 = 0
  use4 = 0.5
  else 
  puts "Nothing"
end

difference5 = (dude[:value] - rubio[:value]).to_f
firstpart5 = (difference5/3).to_f
tdist5 = (Statistics2.tdist(2,firstpart5)).to_f
tdistabs5 = (Statistics2.tdist(2,firstpart5.abs)).to_f
percent5 = tdist5
percentabs5 = tdistabs5
opercent5 = (1-tdist5)
opercentabs5 = (1-tdistabs5)
case 
  when difference5 < 0
  use5 = opercentabs5.round(2)
  when difference5 > 0
  use5 = percentabs5.round(2)
  when difference5 = 0
  use5 = 0.5
  else 
  puts "Nothing"
end


case
  when answer = "Trump"
    trump_score = ((use2*use3*use4*use5)*100).round(2)
    puts "#{trump_score}""%"
  when answer = "Jeb Bush"
	bush_score = ((use1*use3*use4*use5)*100).round(2)
	puts "#{bush_score}""%"
  when answer = "Carson"
    carson_score = ((use1*use2*use4*use5)*100).round(2)
    puts "#{carson_score}""%"
  when answer = "Walker"
    walker_score = ((use1*use2*use3*use5)*100).round(2)
    puts "#{walker_score}""%"
  when answer = "Rubio"
    rubio_score = ((use1*use2*use3*use4)*100).round(2)
    puts "#{rubio_score}""%"
  else
    puts "Wrong input."
end


