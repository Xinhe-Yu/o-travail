class UserProfile
  include ActiveModel::Model
  include ActiveModel::Validations
  include SharedMethods

  attr_accessor :birthday, :profession, :terminology_preference, :experience

  # profession ["Employé", "Employeur / Responsable RH", "Avocat / Conseiller Juridique", "Syndicaliste / Représentant du Personnel"]
  # terminology_preference ["Accessible / Simplifié", "Juridique / Technique", "Historique / Contextuel"]
  # experience ["Débutant", "Professionnels Expérimentés"]

end
