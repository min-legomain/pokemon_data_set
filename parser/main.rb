require './parser/pokemon_parser/pokemon_parser'
require './parser/move_parser/move_parser'

def excute
  PokemonParser.new.parse('./data/orig/csv/ポケモンデータシート.csv')
  MoveParser.new.parse('./data/orig/csv/技データリスト.csv')
end

excute
