require 'tqdm'
Article.destroy_all

file_path = "db/code_du_travail.json"
file = File.read(file_path)

def clean_path(raw)
  paths = JSON.parse(raw)
  paths[-1] = paths[-1][0..-2] if paths[-1].end_with?(".")
  title = []
  paths.each do |path|
    title << path.split(":")[-1].strip if path.include?(":")
    break if path.start_with?("Section")
  end
  title = title[-1]
  return paths, title
end

def clean_texte(raw)
  contiguous_p_tag = /<\/p>\W*<p>/
  start_and_end_p_tag = /<\/?p>/
  a_tag = /<a\s+([^>]*)>([^<]*)<\/a>/i
  internal_content_pattern = /[L|D|R]\.?\W?\d{1,4}(-\d{1,3})*\z/
  external_content_pattern = /[A-Z]{4}TEXT\d{12}/
  raw = raw.gsub(contiguous_p_tag, "<br><br>")
  raw = raw.gsub(start_and_end_p_tag, "")
  raw = raw.gsub(a_tag) do |match|
    attributes = Regexp.last_match(1)
    content = Regexp.last_match(2)
    attributes.gsub!(/href=['|"][^"']*['|"]/, 'href="') if internal_content_pattern.match?(content)
    attributes.gsub!(/href=['|"][^"']*['|"]/, "href='https://www.legifrance.gouv.fr/loda/id/#{attributes[external_content_pattern]}'")
    "<a #{attributes}>#{content.strip}</a>#{" " if content != content.strip}"
  end
  raw.gsub(/\A(<br\s*\/?>)+/, '').gsub(/(<br\s*\/?>)+\z/, '')
end

JSON.parse(file).tqdm.each do |line|
  art = Article.new
  art.ref_num = line["article_id"].to_i
  art.art_num = line["article_num"]
  art.loc, art.title = clean_path(line["path_title"])
  art.text = clean_texte(line["texte"])
  art.status = line["etat"]
  art.ord_num = line["order_num"].to_i
  art.start_date = Date.parse(line["date_deb"])
  art.end_date = Date.parse(line["date_fin"]) unless line["date_fin"] == "2999-01-01"
  art.save!
end
