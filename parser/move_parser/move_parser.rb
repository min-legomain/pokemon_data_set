require 'csv'
require 'json'

class MoveParser
    def parse(csv_file_path)
        orig_hash=CSV.read(csv_file_path, headers: true).map(&:to_hash)
        parsed=[]
        orig_hash.each do |item|
            parsed << MoveData.new(item).parse
        end
        File.open("./data/parsed/move_data_set/move_data_set_#{Time.now}.json", 'w') do |file|
            file.write(parsed.to_json)
            file.close
        end
    end

    class MoveData
			def initialize(hash)
				@name=hash['名前']
        @type=hash['タイプ']
        @category=hash['分類']
        @power=hash['威力'].to_i
        @accuracy=hash['命中'].to_i
        @pp=hash['PP']
        @is_physical=hash['直接'].to_s=='直○'
        @subject=hash['対象']
        @description=hash['説明']
			end

			def parse
				{
					name:@name,
          type:@type,
          category:@category,
          power:@power,
          accuracy:@accuracy,
          pp:@pp,
          is_physical:@is_physical,
          subject:@subject,
          description:@description
				}
			end
    end
end
