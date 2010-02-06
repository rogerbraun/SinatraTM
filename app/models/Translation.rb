class Translation
  include DataMapper::Resource

  property :id, Serial
  property :source, Text
  property :target, Text

end

