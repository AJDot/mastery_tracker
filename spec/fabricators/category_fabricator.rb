Fabricator(:category) do
  name { Faker::Lorem.words(1).join(" ") }
  user { Fabricate(:user) }
end
