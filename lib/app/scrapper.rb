#SPECIFICATION Class Scrapper
#But de ce programme :
# Recuperer tout d'abord la liste des url pour les # mairies du val d'oise
# Recuperer sur chacune de ces pages l'adresse mail pour les joindre

# ¿WHY?
# Cette classe extrait les données des mairies (code récupéré du projet Week2-Project4) 

class Scrapper
	URL = "http://annuaire-des-mairies.com/val-d-oise.html"
	#Constructeur
	def initialize
	end
	#lance la recolte des emails, retourne le hash des mails
	def perform
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

	private
	#decoupage de la methode perform, ici on recupere les emails depuis les Urls des mairies
	def get_townhall_email
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

