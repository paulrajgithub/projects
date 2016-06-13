require 'nokogiri'
require 'open-uri'
require "net/http"
require "uri"

class HomeController < ApplicationController

	def index
		table=nil
		table = getFullTable 	"http://www.premierleague.com/en-gb/matchday/league-table.html",{"position"=>0, "clubName"=>3, "played"=>4, "win"=>5, "draw"=>6, "loss"=>7, "goalScored"=>8, "goalAgainst"=>9, "goalDiff"=>10, "points"=>11}, true
		if table.nil?
			table = getFullTable 	"http://www.eurosport.com/football/premier-league/standing.shtml",{"position"=>0, "clubName"=>1, "played"=>3, "win"=>4, "draw"=>5, "loss"=>6, "goalScored"=>7, "goalAgainst"=>8, "goalDiff"=>9, "points"=>10}, false
		end
		if table.nil?
			table = getFullTable 	"http://www.skysports.com/football/competitions/premier-league/tables",{"position"=>0, "clubName"=>1, "played"=>2, "win"=>3, "draw"=>4, "loss"=>5, "goalScored"=>6, "goalAgainst"=>7, "goalDiff"=>8, "points"=>9}, false
		end 
		# table = getFullTable 	"http://www.eurosport.com/football/premier-league/",{"position"=>0, "clubName"=>1, "played"=>2, "win"=>3, "draw"=>4, "loss"=>5, "goalScored"=>6, "goalAgainst"=>7, "goalDiff"=>8, "points"=>9}, false

		render json: table

	end
	def getSmallTable
		table=[]
		uri = URI.parse("http://fantasy.premierleague.com")
		http = Net::HTTP.new(uri.host, uri.port)
		# request = Net::HTTP::Get.new(uri.request_uri)
		# request.basic_auth("adet4ever@hotmail.com", "01_awo1")
		# response = http.request(request)
		http.start do |connection|
	       request = Net::HTTP::Get.new(uri.request_uri)
	       request.basic_auth 'adet4ever@hotmail.com', '01_awo1'

	       request.body = 'something if needed'

	       response = connection.request(request)

	       # do other stuff with the same connection...
	       # doc = Nokogiri::HTML(open('http://fantasy.premierleague.com'))
	        doc = Nokogiri::HTML(open('http://www.premierleague.com/en-gb/matchday/league-table.html'))
			rows = doc.css("table tr") 
			rows.each do |row|

				unless row.css("td").nil?
					data=[]
					row.css("td").each do |td|
						data.push(td.text)
					end
					if not data.nil? and not data==[]
						clubname = data[0]
						played = data[1]
						points = data[2]
						unless clubname.nil?
							clubname=clubname.strip
						end
						unless played.nil?
							played=played.strip
						end
						unless points.nil?
							played=played.strip
						end
						if not clubname.nil? and not clubname==""
							club={
								"clubname"=>clubname,
								"played"=>played,
								"points"=>points
							}
							table.push(club)
						end
					end
				end
			end
			x=3
	     end
		render json: nil
	end

	def getFullTable url, columns=nil, skippOddRows=false
		if columns.nil?
			columns= {"position"=>0, "clubName"=>3, "played"=>4, "win"=>5, "draw"=>6, "loss"=>7, "goalScored"=>8, "goalAgainst"=>9, "goalDiff"=>10, "points"=>11}
		end
		table=[]
		uri = URI.parse(url)
		http = Net::HTTP.new(uri.host, uri.port)
		http.start do |connection|
			request = Net::HTTP::Get.new(uri.request_uri)
			doc = Nokogiri::HTML(open(url))
			newrows=[]
			count=-1
			rows = doc.css("table tr") 
			rows.each do |row|
				unless row.css("td").nil?
					data=[]
					row.css("td").each do |td|
						data.push(td.text)
					end
					if not data.nil? and not data==[]
						club={}
						columns.each do |key, value|
							tempValue = data[value]
							if not tempValue.nil? and not tempValue==""
								tempValue = tempValue.strip 
							end
							if skippOddRows and count%2==0
								club[key]=tempValue
							elsif not skippOddRows
								club[key]=tempValue
							end
						end
						if not club.nil? and not club=={}
							table.push(club)
						end
					end
				end
				count=count+1
			end
	  end
		return table
	end

	def getNextFixture

	end
end