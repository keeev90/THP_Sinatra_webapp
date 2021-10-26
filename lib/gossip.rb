class Gossip #Model

  attr_accessor :author, :content #variables d'instance passées en tant que paramètres pour pouvoir les appliquer sur un objet (ex : gossip.author)

  def initialize(author, content) #définir des variables d'instance
    @author = author
    @content = content
  end

  def save #méthode qui enregistre dans une base de données l'objet sur laquelle elle est appliquée.
    CSV.open("./db/gossip.csv", "ab") do |csv| #ouvrons le CSV en mode écriture
      csv << [author, content] #insertion d'une ligne avec deux colonnes
    end
  end

  def self.all # self. >>> méthode qui s'applique à une classe entière (et non sur une instance en particulier). Idéal pour jouer sur toutes les instances d'une même classe.
    all_gossips = []
    CSV.read("./db/gossip.csv").each do |csv_line|
      all_gossips << Gossip.new(csv_line[0], csv_line[1])
    end
    return all_gossips ##on retourne un array rempli d'objets Gossip
  end

  def self.find(id) # Méthode à appliquer sur la classe Gossip pour récupérer dans notre BDD le potin N°x et qui ressort le gossip correspondant. 
    all_gossips = Gossip.all
    return all_gossips[id]
  end

end