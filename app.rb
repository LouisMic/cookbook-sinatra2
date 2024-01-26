require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "csv"

require_relative "cookbook"
require_relative "recipe"

csv_file   = File.join(__dir__, 'recipes.csv')
cookbook   = Cookbook.new(csv_file)

get "/" do
  @recipes = cookbook.all
  erb :index
end

get "/new" do
  erb :new
end

post "/recipes" do
  recipe = Recipe.new(name: params["name"], description: params["description"], rating: params["rating"], prep_time: params["prep_time"])
  cookbook.create(recipe)
  redirect to "/"
end

get "/recipes/:index" do
  cookbook.destroy(params[:index].to_i)
  redirect to "/"
end
