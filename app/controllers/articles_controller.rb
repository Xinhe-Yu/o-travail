class ArticlesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index]
  before_action :set_search_word, only: %i[index]

  def index

    if params[:key_word].empty?
      @articles = Article.all
    else
      @search_word = params[:key_word]
      p set_search_word
      @articles = Article.search_by_title_and_text(set_search_word)
    end

    @length = @articles.count
    @articles = @articles.first(25)
  end

  private

  def set_search_word
    return nil if params[:key_word].empty?

    code_pattern = /^([L|l]?'?article\W?)?([L|D|R]\.\W?\d{1,4}(-\d{1,3})*)/
    words = params[:key_word].split.map do |word|
      return "Compte personnel de formation" if word == "CPF"

      match = word.match(code_pattern)
      return word unless match

      match[2].gsub!(/[\.|\s]/, "")
    end
    words.join(" ")
  end
end
