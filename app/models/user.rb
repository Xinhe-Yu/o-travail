class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :questions, dependent: :destroy

  PROFESSION = ["Employé", "Employeur / Responsable RH", "Avocat / Conseiller Juridique", "Syndicaliste / Représentant du Personnel"]
  TERMINOLOGY_PREFERENCE = ["Accessible / Simplifié", "Juridique / Technique", "Historique / Contextuel"]
  EXPERIENCE = ["Débutant", "Professionnels Expérimentés"]

  def experience_level
    return if experience.nil?

    "#{EXPERIENCE[experience]} comme son niveau d'experience "
  end

  def profession_level
    return if profession.nil?

    "#{PROFESSION[profession]} comme sa profession"
  end

  def terminology_preference_level
    return if terminology_preference.nil?

    TERMINOLOGY_PREFERENCE[terminology_preference]
  end
end
