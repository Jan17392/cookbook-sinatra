require_relative 'cookbook'
require_relative 'recipe'

class Controller
  def initialize(cookbook)
    @cookbook = cookbook
  end

  def list
    @cookbook.all
  end

  def create(recipe_name, recipe_description)
    created_recipe = Recipe.new(recipe_name, recipe_description)
    @cookbook.add_recipe(created_recipe)
  end

  def destroy(id)
    @cookbook.remove_recipe(id)
  end
end
