class Recipe
  attr_reader :name, :description, :rating, :picture
  def initialize(name, description, rating = "", picture = "")
    @name = name
    @description = description
    @rating = rating
    @picture = picture
  end
end
