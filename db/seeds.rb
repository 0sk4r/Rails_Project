Author.create!([
                 { nick: 'a', email: 'a@a.pl', password: '123456', reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil }
               ])
Category.create!([
                   { name: 'all' }
                 ])
Post.create!([
               { title: 'sdf', content: 'fasfdasf', author_id: 1, category_id: 1 }
             ])
