# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Category.create([{title: "Car"},
                 {title: "Design"},
                 {title: "Fashion"},
                 {title: "Food"},
                 {title: "Health"},
                 {title: "Movie"},
                 {title: "Music"},
                 {title: "Nature"},
                 {title: "Photography"},
                 {title: "Sports"},
                 {title: "Technology"},
                 {title: "Travel"}])

Tag.create([{name: "Branding"},
            {name: "Communication"},
            {name: "Dreams"},
            {name: "Event"},
            {name: "Games"},
            {name: "Images"},
            {name: "Mobile"},
            {name: "Personal development"},
            {name: "Promotion"},
            {name: "Review"},
            {name: "Self"},
            {name: "Today"}])
