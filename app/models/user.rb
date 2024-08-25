class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :questions

  # profession ["Employé", "Employeur / Responsable RH", "Avocat / Conseiller Juridique", "Syndicaliste / Représentant du Personnel"]
  # terminology_preference ["Accessible / Simplifié", "Juridique / Technique", "Historique / Contextuel"]
  # experience ["Débutant", "Professionnels Expérimentés"]
end
