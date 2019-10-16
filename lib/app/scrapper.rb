#SPECIFICATION Class Scrapper
#But de ce programme :
# Recuperer tout d'abord la liste des url pour les # mairies du val d'oise
# Recuperer sur chacune de ces pages l'adresse mail pour les joindre

# ¿WHY?
# Cette classe extrait les données des mairies (code récupéré du projet Week2-Project4) 

class Scrapper
	URL = "http://annuaire-des-mairies.com/val-d-oise.html"
	attr_accessor :my_hash
	#Constructeur
	def initialize
		@my_hash = Hash.new
		@my_hash = scrapping
	end
	#lance la recolte des emails, retourne le hash des mails
	def perform
		display_menu

		user_input = -1
		while (user_input > 4) || (user_input < 0 )do
			puts "Veuillez entrer votre choix"
			print "> "
			user_input = gets.to_i
		end
		process(user_input)
	end

	private
	#this method handles the menu
	#this method save our hash in a save_as_csv
	def save_as_csv
		CSV.open("./lib/db/emails.csv", "w") {|csv| my_hash.each {|tab| tab.each {|elem| csv << elem}}}
		puts "File successfuly saved as emails.csv"
	end
	#This method save our hash in a spreadsheet
	def save_as_spreadsheet
		session = GoogleDrive::Session.from_config("config.json")
		ws = session.spreadsheet_by_key("1Ol56rFlKCKDx4IWozZ3NSTQDQHQ3AuEjVMVlvszjouA").worksheets[0]
		@my_hash.size.times do |index|
			ws[index+1, 1] = @my_hash[index].keys[0]
			ws[index+1, 2] = @my_hash[index].values[0]
		end
		ws.save
		puts "File successfuly saved in spreadsheet"

	end
	#This method save our hash in Json
	def save_as_json
		File.open("./lib/db/emails.json","w") do |f|
			@my_hash.each {|x|  x.each{ |y| f.write(y.to_json)}}
		  
		end
		puts "File successfuly saved as emails.json"
	end
	#this method process the user choice for export format
	def process(user_input)
		case user_input
		when 1 
			save_as_csv
			perform
			return
		when 2
			save_as_json
			perform
			return
		when 3
			save_as_spreadsheet
			perform
			return
		when 4
			"Bye !"
			return
		else
			puts "ERROR - with the user_input conditions"
		end
	end
	#This method displays the menu
	def display_menu
		puts "Veuillez choisir le format d'export :"
		puts "1. CSV"
		puts "2. Json"
		puts "3. Spreadsheet"
		puts "4. Quitter"
	end
	# this method start the scrapping
	def scrapping
		list_url = get_townhall_urls.map {|x|
			URL[0..30] + x.text[1..-1]
		}
		list_hash = []
		for a in 0..list_url.size-1 do 
			list_hash[a]= Hash.new
			list_hash[a]= get_townhall_email(list_url[a])
		end

		puts "We found #{list_hash.length } townhalls and saved their emails "
		return list_hash
	end
	#decoupage de la methode perform, ici on recupere les emails depuis les Urls des mairies
	def get_townhall_email(townhall_url)
		return nil if townhall_url.nil? || townhall_url.empty?
		mail_hash = Hash.new
		city_name = townhall_url[35..-6]
		list_mail = Nokogiri::HTML(open(townhall_url)).xpath("//*[contains(text(), '@')]")
		list_mail.each { |mail|
			mail_hash[city_name]= mail.text
		}
		if mail_hash.empty? then
			puts "Echec ".red+": No mail found for #{city_name}" 
		else
			puts "Succes ".green+"Extraction des emails de la mairie de #{city_name}"
		end
	return mail_hash
	end
	#decoupage de la methode perform, ici on recupere les URLS des mairies du val d'oise
	def get_townhall_urls
		page = Nokogiri::HTML(open(URL)).xpath("//a[@class='lientxt']/@href")
		puts "Annuaire du val d'oise bien récuperé, extraction des url des mairies" if page.any?
	return page
	end
end

