require 'csv'
require 'json'

class PokemonParser
    def parse(csv_file_path)
        orig_hash=CSV.read(csv_file_path, headers: true).map(&:to_hash)
        parsed=[]
        orig_hash.each do |item|
            parsed << PokemonData.new(item).parse
        end
				parsed.sort_by! { |hash| hash[:no] }
        File.open("./data/parsed/pokemon_data_set/pokemon_data_set_#{Time.now}.json", 'w') do |file|
            file.write(parsed.to_json)
            file.close
        end
    end

    class PokemonData
			def initialize(hash)
				@no=hash['ぜんこくNo.'].to_i
				@name=hash['名前(フォルム)'].to_s
				@eng_name=hash['英語名']
				@type_1=hash['タイプ1']
				@type_2=hash['タイプ2']
				@ability_1=hash['とくせい1']
				@ability_2=hash['とくせい2']
				@hidden_ability=hash['夢特性']&.delete('*')
				@hp=hash['HP'].to_i
				@attack=hash['攻撃'].to_i
				@defense=hash['防御'].to_i
				@sp_attack=hash['特攻'].to_i
				@sp_defense=hash['特防'].to_i
				@speed=hash['素早さ'].to_i
			end

			def parse
				{
					no: @no,
					name: @name,
					eng_name: @eng_name,
					types: types,
					abilities: abilities,
					hp: @hp,
					attack: @attack,
					defense: @defense,
					sp_attack: @sp_attack,
					sp_defense: @sp_defense,
					speed: @speed,
					total_stats: total_stats
				}
			end

			private

			def abilities
				[@ability_1,@ability_2,@hidden_ability].compact
			end

			def types
				[@type_1,@type_2].compact
			end

			def total_stats
				[@hp,@attack,@defense,@sp_attack,@sp_defense,@speed].sum
			end
    end
end
