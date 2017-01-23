require 'csv'
require_relative 'recipe'

class Cookbook
  attr_reader :cookbook

  def initialize(csv_file)
    @cookbook = []
    @csv_file = csv_file
    @csv_text = File.read(@csv_file)
    csv = CSV.parse(@csv_text)

    csv.each do |row|
      @cookbook << Recipe.new(row[0], row[1], row[2], row[3])
    end
  end

  def all
    @cookbook.map { |recipe| puts "#{recipe.name} #{recipe.description} #{recipe.rating} #{recipe.picture}" }
    @cookbook
  end

  def add_recipe(recipe)
    csv_options = { col_sep: ",", force_quotes: false }
    @cookbook << recipe

    CSV.open(@csv_file, 'ab', csv_options) do |csv|
      csv << [recipe.name, recipe.description, recipe.rating, recipe.picture]
    end
  end

  def remove_recipe(recipe_id)
    @cookbook.delete_at(recipe_id)
    csv_options = { col_sep: ",", force_quotes: true, quote_char: '"' }
    CSV.open(@csv_file, 'wb', csv_options) do |csv|
      @cookbook.each do |recipe|
        csv << [recipe.name, recipe.description, recipe.rating, recipe.picture]
      end
    end
  end
end
