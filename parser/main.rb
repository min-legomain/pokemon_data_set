require './pokemon_parser/parser.rb'
def excute
  Parser.new.parse('../data/orig/from.json')
end

excute