# TODO: Implement the Cookbook class that will be our repository
require_relative 'recipe'
require "csv"

class Cookbook
  def initialize(csv_file_path)
    @filepath = csv_file_path
    @recipes = []
    load_csv
  end

  def all
    @recipes
  end

  def find(index)
    @recipes[index]
  end

  def create(recipe)
    @recipes << recipe
    save_csv
  end

  def destroy(index)
    @recipes.delete_at(index)
    save_csv
  end

  private

  def save_csv
    CSV.open(@filepath, "wb") do |csv|
      csv << ["name", "description", "rating", "prep_time", "done"]
      @recipes.each { |recipe| csv << [recipe.name, recipe.description, recipe.rating, recipe.prep_time, recipe.done?] }
    end
  end

  def load_csv
    CSV.foreach(@filepath, headers: :first_row, header_converters: :symbol) do |row|
      row[:done] = row[:done] == "true"
      @recipes << Recipe.new(row)
    end
  end
end
