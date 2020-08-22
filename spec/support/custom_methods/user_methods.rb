def create_user
    User.create!(name: 'Username', email: 'test@test.com', password: 'password')
end
