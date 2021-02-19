class Color < ActiveHash::Base
  self.data = [
    { id: 1, name: '----' },
    { id: 2, name: "Red" },
    { id: 3, name: 'Pink' },
    { id: 4, name: 'Orange' },
    { id: 5, name: 'Blue' },
    { id: 6, name: 'SkyBlue' },
    { id: 7, name: 'Green' },
    { id: 8, name: 'LightGreen' },
    { id: 9, name: 'Purple' },
  ]

  include ActiveHash::Associations
  has_many :books
end