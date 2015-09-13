require 'pg'
require 'pry'

def db_connection
  begin
    connection = PG.connect(dbname: "brussels_sprouts_recipes")
    yield(connection)
  ensure
    connection.close
  end
end


TITLES = [
  "Roasted Brussels Sprouts",
  "Fresh Brussels Sprouts Soup",
  "Brussels Sprouts with Toasted Breadcrumbs, Parmesan, and Lemon",
  "Cheesy Maple Roasted Brussels Sprouts and Broccoli with Dried Cherries",
  "Hot Cheesy Roasted Brussels Sprout Dip",
  "Pomegranate Roasted Brussels Sprouts with Red Grapes and Farro",
  "Roasted Brussels Sprout and Red Potato Salad",
  "Smoky Buttered Brussels Sprouts",
  "Sweet and Spicy Roasted Brussels Sprouts",
  "Smoky Buttered Brussels Sprouts",
  "Brussels Sprouts and Egg Salad with Hazelnuts"]

  COMMENTS = [
   {0 => "Wow Mexico!"},
   {1 => "Wow MLG is a fantastic Mentor!"},
   {2 => "Cristina gave a great lecture the other day!"},
   {3 => "Jarlex is very funny"},
   {4 => "Richard Davis is the next Wozniak"},
   {5 => "Philip knows all the atom tricks."},
   {6 => "Leise has a really wierd keyboard"},
   {7 => "Taco shells are not mexican"},
   {8 => "Tacos al Pastor are"},
   {9 => "I am going to give a fantastic mexico presentation on Tuesday"},
   {10 => "Life is full of fools who want to fall in love"},
   {8 => "D-Rod is very cool also!"},
   {2 => "Aja has the coolest name, because it sounds like the continent"},
   {4 => "Tim is very good at math"}
  ]

#WRITE CODE TO SEED YOUR DATABASE AND TABLES HERE

db_connection do |conn|
  TITLES.each_with_index do |index, item|
    conn.exec_params("INSERT INTO recipes (recipe, recipe_id) VALUES ($1, $2)", [index, item])
  end
  COMMENTS.each do |hash|
    hash.each do |key, value|
      conn.exec_params("INSERT INTO comments (comment_id, comment) VALUES ($1, $2)", [key, value])
    end
  end
end


#
# # QUESTIONS, in SQL code
# # How many recipes are there in total?
# select count(recipe) from recipes;
#
# This is how you would do it for ruby code, to run SQL
#   mlg = db_connection { |conn| conn.exec("select count(recipe) from recipes;")}
# 
#   puts mlg.first
#
# # How many comments are there in total?
# select count(comment) from comments;
#
# # How would you find out how many comments each of the recipes have?
# select count(*) from comments where comment_id = 4;
#
# # What is the name of the recipe that is associated with a specific comment?
# select recipes.recipe
# from recipes
# inner join comments
# on recipes.recipe_id = comments.comment_id
# where comments.comment = ('Wow Mexico!');
#
# # Add a new recipe titled Brussels Sprouts with Goat Cheese. Add two comments to it.
# insert into recipes (recipe, recipe_id) values ('Mario is the coolest TV', 11);
# insert into comments (comment, comment_id) values ('Taco Ponies would be a fantastic dish', 11);
# insert into comments (comment, comment_id) values ('Tacos al Pony', 11);
