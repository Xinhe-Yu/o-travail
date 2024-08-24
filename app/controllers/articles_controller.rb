class ArticlesController < ApplicationController
  def index
    @articles = Article.first(25)
  end
end
