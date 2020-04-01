require_relative "../../config/environment"

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, "public"
    set :views, "app/views"
  end

  get "/" do
  end

  get "/articles" do
    @articles = Article.all
    erb :'articles/index'
  end

  get "/articles/new" do
    erb :'articles/new'
  end
  get "/articles/:id" do
    @article = Article.find(params[:id])
    erb :'articles/show'
  end

  post "/articles" do
    @article = Article.new(params)
    if @article.valid?
      @article.save
      redirect "/articles/#{@article.id}"
    else
      erb :'articles/new', locals: { message: "Something went wrong with your article" }
    end
  end

  get "/articles/:id/edit" do
    @article = Article.find(params[:id])
    erb :'articles/edit'
  end

  patch "/articles/:id" do
    @article = Article.find(params[:id])
    @article.title = params["title"]
    @article.content = params["content"]
    @article.save
    redirect "/articles/#{@article.id}"
  end

  delete "/articles/:id" do
    @article = Article.find(params[:id])
    @article.destroy if @article
    redirect "/articles"
  end
end
