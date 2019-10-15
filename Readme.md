THP - Week 3 - Project 3 - Play with excel

François THIOUNN

NOTES :
afin de faire marcher la fonction save_to_spreadsheet il faut creer un fichier config.json et y glisser son api et sa clef de google
Se ref a la doc THP

HF

FT

Projet : Sauvegarder des données en masse
  
1. Introduction
Ensemble, nous allons sauvegarder tout un tas de données dans une base sous la forme d'une spreadsheet, d'un CSV ou d'un JSON. Tous les programmes du jour devront être faits en POO : tout doit être contenu dans des classes, 1 classe par fichier. Finis les petits programmes faits à la va-vite.

2. Le projet
Le projet du jour a pour but d'enregistrer dans 3 formats différents les e-mails du Val d'Oise (tu te rappelles bien sûr de ce projet, hein ?). Pour ce faire, reprends le programme que tu avais fait précédemment et mets dans une belle classe. Bien entendu (et cela vaudra pour TOUS les projets à venir), ton programme sera inclus dans un dossier bien structuré.

A chaque format, tu vas créer une méthode spécifique pour enregistrer le résultat de ton scrappeur.

2.1. Enregistrer dans un JSON
Tu voudrais éviter de faire tourner ton scrappeur à chaque fois que tu reboots ton ordi : il faut en sauvegarder les données ! JSON étant un format standard, tu décides de le faire sous un fichier emails.JSON.

Créé une méthode save_as_JSON qui prend le résultat de ton scrapper et enregistre dans ton ordi les emails du Val d'Oise. Si tu as enregistré le résultat de ton scrapping au format suivant : {"ABLEIGES"=>"mairie.ableiges95@wanadoo.fr", "AINCOURT"=>"mairie.aincourt@wanadoo.fr", etc }, il te faut passer sur chaque couple clé-valeur du hash. À chaque passage, tu vas ajouter du contenu dans ton fichier JSON.

On te laisse utiliser les ressources du jour pour produire un joli JSON.

2.2. Google Spreadsheet
À présent, c'est le CEO de Get-Email Corp qui voudrait que tu puisses lui envoyer tes résultats par e-mail. Cependant, ce dernier est un peu old school : il ne comprend pas comment obtenir la liste d’e-mails à partir d'un fichier scrapping.rb, ne pige rien au format JSON et refuse de suivre The Hacking Project. Comme le client est roi, la seule façon de lui fournir ces e-mails est de le faire via un fichier Google Spreadsheet. Ta mission est donc de trouver un moyen de faire un fichier Google Spreadsheet qui contienne en colonne A les noms des villes, et en colonne B les e-mails des dites mairies.

Nous te conseillons de travailler sur un fichier spreadsheet que tu vas créer pour l'occasion. Ces quelques lignes de code t'indiquent comment ouvrir un spreadsheet à partir de Ruby.

Tout ce travail de sauvegarde se fera via une méthode save_as_spreadsheet

2.2. Enregistrer dans un CSV
Une fois le résultat livré à Get-Email Corp, tu te sens l'âme d'un Julien Assange et tu veux balancer le fichier sur jeux-video.com. La communauté t'incite fortement à le faire en CSV (et toi, t'es très sensible à ce que la communauté veut).

Enregistre maintenant les données dans un CSV grâce à une méthode save_as_csv

3. Rendu attendu
Un dossier qui scrappe les mairies et qui les enregistre dans les trois types vus aujourd'hui. La structure devrait ressembler à ceci :

mon_projet
├── lib
│   ├── app
│   │   └── scrapper.rb
├── db
│   └── emails.csv
│   └── emails.json
├── spec
│   ├── spec_helper.rb
│   └── scrapper_spec.rb
├── app.rb
├── README.md
├── Gemfile
├── Gemfile.lock
├── Autres fichiers (.env, .gitignore)
└── .rspec
Tu peux rajouter un petit menu si tu veux pour laisser le choix du format-cible à l'utilisateur.