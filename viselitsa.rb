
require_relative "game.rb"
require_relative "result_printer.rb"
require_relative "word_reader.rb"


# XXX/ Этот код необходим только при использовании русских букв на Windows
if (Gem.win_platform?)
  Encoding.default_external = Encoding.find(Encoding.locale_charmap)
  Encoding.default_internal = __ENCODING__
#
  [STDIN, STDOUT].each do |io|
    io.set_encoding(Encoding.default_external, Encoding.default_internal)
  end
end


current_path = File.dirname(__FILE__)

puts "Игра виселица. Версия 3. C чтением данных из файлов. \n\n"

# создаем объект, печатающий результаты
printer = ResultPrinter.new

# создаем объект, отвечающий за ввод слова в игру
word_reader = WordReader.new

# Имя файла, откуда брать слово для загадывания
words_file_name = current_path + "/data/words.txt"

# создаем объект типа Game, в конструкторе передаем загаданное слово из word_reader-а
game = Game.new(word_reader.read_from_file(words_file_name))

# основной цикл программы, в котором развивается игра
# выходим из цикла, когда объект игры сообщит нам, c пом. метода status
while game.status == 0 do
  # выводим статус игры
  printer.print_status(game)
  # просим угадать следующую букву
  game.ask_next_letter
end

printer.print_status(game)

