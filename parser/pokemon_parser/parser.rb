require 'json'

class Parser
    def parse(json_file_path)
        orig=JSON.parse(File.read(json_file_path))
        parsed=[]
        orig.each do |item|
            parsed << PokemonDataSet.new(item).parse
        end
        File.open("../data/parsed/pokemon_data_set/pokemon_data_set_#{Time.now}.json", 'w') do |file|
            file.write(parsed.to_json)
            file.close
        end
    end

    class PokemonDataSet
        def initialize(hash)
            @no=hash['no'].to_i
            @name=hash['name'].to_s
            @types=hash['types']
            @abilities=hash['abilities']
            @hidden_abilities=hash['hiddenAbilities']
            @stats=hash['stats']
        end

        def parse
            {
                no: @no,
                name: @name,
                types: @types,
                abilities: @abilities,
                hidden_abilities: @hidden_abilities,
                stats: @stats
            }
        end
    end
end
