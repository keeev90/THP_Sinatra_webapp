require 'gossip' #lier les classes entre elles

class ApplicationController < Sinatra::Base #hérite (<) de la classe Sinatra::Base. Grâce à l'héritage, ApplicationController aura toutes les fonctionnalités que propose la classe Sinatra::Base (= toutes les fonctionnalités de base de Sinatra).
  
  get '/' do #dit à l'appli Sinatra "si quelqu'un va sur l'URL '/', exécute le code qui suit, en l'occurence envoie-lui des views' "
    erb :index, locals: {gossips: Gossip.all} # Passer une variable à une view (via les routes) >>> méthode 'locals' permet d'envoyer à notre fichier ERB des variables que l'on utilisera.
  end

  get '/gossips/new/' do
    erb :new_gossip
  end

  post '/gossips/new/' do #dit à l'appli Sinatra "hey bro, récupère les informations du formulaire et convertis-les en une création de gossip dans ma base". On pourrait y mettre n'importe quoi d'autre, par exemple tout un programme exécuté au submit du formulaire.
    Gossip.new(params["gossip_author"], params["gossip_content"]).save #crée la nouvelle instance de Gossip. Et en lui appliquant un .save, on veut qu'elle soit inscrite dans la base de donnée. 
    redirect '/' #dit à Sinatra "maintenant, redirige le user vers cette route" (la homepage par exemple ou une page de recap/confirmation après un paiement...)
  end

  ### Focus sur params ###
  # Quand l'utilisateur soumet le formulaire, params récupère son contenu et le stocke avec les noms qu'on avait choisis pour chaque champ de texte
  # WARNING : le contenu de params ne persiste que d’une page sur l’autre. Le hash se vide à chaque requête HTTP (changement de page). Il faut donc récupérer le contenu immédiatement après la saisie, sinon c'est perdu !

  get '/gossips/:id/' do #route dynamique avec une variable d'URL ":id" >>> à chaque fois qu'un utilisateur rentre une URL du type http://localhost:4567/gossips/x/, Sinatra comprend que l'on veut voir la page show du potin N°x en BDD
    erb :show, locals: {gossip: Gossip.find(params["id"])} #passer la variable à utiliser dans une view (avec du code Ruby directement dans la view Show), en l'occurence l'id du gossip que l'utilisateur souhaite afficher (= l'id est ici un paramètre indiqué par l'utilisateur)
  end

end

