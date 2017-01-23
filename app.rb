require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"
require 'open-uri'
require_relative 'cookbook'
require_relative 'recipe'
require_relative 'controller'
require_relative 'recipe_importer'

set :bind, '0.0.0.0'

configure do
    set :csv_file, File.join(__dir__, 'recipes.csv')
    set :cookbook, Cookbook.new(settings.csv_file)
    set :recipe_importer, RecipeImporter.new
end


configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

get '/show' do
  @recipes = settings.cookbook.all
  erb :show
end

get '/' do
  erb :index
end

get '/new' do
  erb :new
end

post '/create' do
  created_recipe = Recipe.new(params[:title], params[:description])
  settings.cookbook.add_recipe(created_recipe)
  redirect '/'
end

get '/delete' do
  @recipes = settings.cookbook.all
  erb :delete
end

post '/destroy' do
  settings.cookbook.remove_recipe(params[:item].to_i)
  redirect '/'
end

post '/import_selection' do
  @recipe = Recipe.new(params[:name], params[:description], params[:rating], params[:picture])
  settings.cookbook.add_recipe(@recipe)
  redirect '/'
end


get '/import' do
  erb :import
end

post '/import_confirm' do
  @results = settings.recipe_importer.parsing(params[:ingredient])
  erb :searchresult
end
