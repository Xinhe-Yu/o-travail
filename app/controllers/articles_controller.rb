class ArticlesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index]

  def index
    @length = Article.count
    @articles = Article.first(25)
    unless params[:key_word].empty?
      @search_word = params[:key_word]
    end
  end
end
