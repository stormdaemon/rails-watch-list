# db/seeds.rb

require "faker"

puts "Cleaning up database..."
Bookmark.destroy_all
Movie.destroy_all
List.destroy_all
puts "Database cleaned."

# === À TOI DE JOUER ===
movie_titles = [
  "Inception",
  "Matirx",
  "Super Mario Bros",
  "Titanic",
  "Spiderman Accross de Spider-Verse"
]

poster_urls = [
  # Mets ici tes URLs de posters, ex :
  # "https://image.tmdb.org/t/p/original/xxxxx.jpg", ...
  "https://m.media-amazon.com/images/I/714b1KQmskL._AC_UF1000,1000_QL80_.jpg",
  "https://static.posters.cz/image/1300/104636.jpg",
  "https://m.media-amazon.com/images/I/71i882VhWvL._AC_UF1000,1000_QL80_.jpg",
  "https://m.media-amazon.com/images/I/71-B0aUFxYL.jpg",
  "https://www.ebay.fr/itm/225511164205"
]

lists_name = [
  "Horror",
  "Fantastic",
  "Incredible",
  "Favourites",
  "Darling's Favourites"
]

puts "Creating movies..."

movie_titles.each_with_index do |title, index|
  Movie.create!(
    title: title,
    overview: Faker::Movie.quote,
    poster_url: poster_urls[index] || "https://via.placeholder.com/300x450.png?text=Poster+Missing",
    rating: rand(5.0..10.0).round(1)
  )
end

puts "#{Movie.count} movies created."

puts "Creating lists..."

lists_name.each do |list_name|
  List.create!(
    name: list_name
  )
end

puts "#{List.count} lists created."

puts "Creating bookmarks..."

5.times do
  Bookmark.create!(
    comment: Faker::TvShows::RickAndMorty.quote,
    movie: Movie.all.sample,
    list: List.all.sample
  )
end

puts "#{Bookmark.count} bookmarks created."
puts "✅ Done!"

puts "Exercise seed..."

Movie.create(title: "Wonder Woman 1984", overview: "Wonder Woman comes into conflict with the Soviet Union during the Cold War in the 1980s", poster_url: "https://image.tmdb.org/t/p/original/8UlWHLMpgZm9bx6QYh0NFoq67TZ.jpg", rating: 6.9)
Movie.create(title: "The Shawshank Redemption", overview: "Framed in the 1940s for double murder, upstanding banker Andy Dufresne begins a new life at the Shawshank prison", poster_url: "https://image.tmdb.org/t/p/original/q6y0Go1tsGEsmtFryDOJo3dEmqu.jpg", rating: 8.7)
Movie.create(title: "Titanic", overview: "101-year-old Rose DeWitt Bukater tells the story of her life aboard the Titanic.", poster_url: "https://image.tmdb.org/t/p/original/9xjZS2rlVxm8SFx8kPC3aIGCOYQ.jpg", rating: 7.9)
Movie.create(title: "Ocean's Eight", overview: "Debbie Ocean, a criminal mastermind, gathers a crew of female thieves to pull off the heist of the century.", poster_url: "https://image.tmdb.org/t/p/original/MvYpKlpFukTivnlBhizGbkAe3v.jpg", rating: 7.0)

puts "Exercise seed applyed"
