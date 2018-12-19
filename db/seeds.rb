Category.create!([
                   { name: 'all' }
                 ])

(1..100).each do |id|
  Author.create!([
                   { nick: "author#{id}", email: "author#{id}@author.pl", password: '123456' }
                 ])
  Post.create!([
                 { title: Faker::Hacker.abbreviation,
                   content: Faker::Hacker.say_something_smart,
                   author_id: id,
                   category_id: 1 }
               ])
end
