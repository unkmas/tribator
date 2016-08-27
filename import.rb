require 'json'

BAD_DEFINITIONS = [
  "имя",
  "мужское имя",
  "женское имя",
  "мужское и женское имя",
  "русская фамилия",
  "река в России"
]

def bad_word?(word)
  word.nil? || word.empty? || word.start_with?('-') || !/^[а-яА-ЯёЁ\-\s]+$/.match(word)
end

def bad_definition?(definition)
  definition.nil? || definition.empty? || BAD_DEFINITIONS.include?(definition)
end


output  = File.open('import.sql', 'w')
output << "insert into tasks(hypernym, description) values\n"

File.foreach('input.json') do |line|
  json = JSON.parse(line)

  next unless json['POS'] == "сущ"

  words = json['word'] || []
  words += (json['synonym'] || []).flatten

  words.uniq.each do |word|
    next if bad_word?(word)

    (json['definition'] || []).each do |definition|
      next if bad_definition?(definition)
      output << "('#{word}','#{definition}'),\n"
    end
  end
end