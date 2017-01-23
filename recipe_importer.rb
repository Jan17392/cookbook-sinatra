require 'nokogiri'
require 'open-uri'

class RecipeImporter
  def parsing(ingredient)
    recipes = []
    doc = Nokogiri::HTML(open("http://www.epicurious.com/search/#{ingredient}?content=recipe&sort=highestRated"), nil, 'utf-8')
    doc.css(".hed").children.each_with_index do |title, index|
      name = title.text.strip
      url = title["href"]
      #description finder
      des = Nokogiri::HTML(open("http://www.epicurious.com" + url), nil, 'utf-8')
      description = des.css(".dek").children.text.strip
      rating = des.css(".rating").children.text.strip
      picture1 = des.css(".photo")
      picture1.length > 0 ? picture = picture1.attr('srcset') : picture = ""
      picture == nil ? picture = "" : picture = picture
      recipes << { name: name, description: description, rating: rating, picture: picture }
    end
    return recipes
  end
end
