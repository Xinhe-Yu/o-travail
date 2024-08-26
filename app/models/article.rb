class Article < ApplicationRecord
  has_neighbors :embedding
  after_create :set_embedding

  include PgSearch::Model
  pg_search_scope :search_by_title_and_text,
                  against: %i[title text art_num],
                  using: {
                    tsearch: { prefix: true }
                  }

  def french_start_date
    french_date(start_date)
  end

  def french_end_date
    return if status

    french_date(end_date)
  end

  def self.normalize_art_num(input_art_num)
    input_art_num.gsub(/[\.|\s]/, "")
  end

  # Search method that uses the normalized code
  def self.search_by_code(input_art_num)
    normalized_art_num = normalize_art_num(input_art_num)
    where("REPLACE(REPLACE(REPLACE(art_num, ' ', ''), '.', ''), 'article', '') LIKE ?", "%#{normalized_art_num}%")
  end

  private

  def set_embedding
    client = OpenAI::Client.new
    response = client.embeddings(
      parameters: {
        model: 'text-embedding-3-small',
        input: "Titre: #{title}. texte: #{text}. #{status ? "En vigueur" : "Abrogé"} le #{status ? start_date : end_date}."
      }
    )
    embedding = response['data'][0]['embedding']
    update(embedding:)
  end

  FRENCH_MONTHS = %w[janvier février mars avril mai juin juillet août septembre octobre novembre décembre]

  def french_date(date)
    day = date.strftime("%-d") == "1" ? "#{date.strftime("%-d")}er" : date.strftime("%-d")
    month = FRENCH_MONTHS[date.month - 1]
    year = date.strftime("%Y")
    "le #{day} #{month} #{year}"
  end
end
