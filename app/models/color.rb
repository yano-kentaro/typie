class Color < ActiveHash::Base
  self.data = [
    { id: 1, name: '----' },
    { id: 2, nemw: 'Red' },
    { id: 3, nemw: 'Pink' },
    { id: 4, nemw: 'Orange' },
    { id: 5, nemw: 'Blue' },
    { id: 6, nemw: 'SkyBlue' },
    { id: 7, nemw: 'Green' },
    { id: 8, nemw: 'LightGreen' },
    { id: 9, nemw: 'Purple' },
  ]

  include ActiveHash::Associations
  has_many :tags
end