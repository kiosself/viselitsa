# Класс, печатающий состояние и результаты игры

class ResultPrinter

  def initialize
    # создадим поле класса, массив, хранящий изображения виселиц
    @status_image = []

    current_path = File.dirname(__FILE__)
    counter = 0 # счетчик шагов

    while counter <=7 do # в цикле прочитаем 7 файлов и запишем из содержимое в массив
      # изображения виселиц лежат в папке /image/ в файлах 0.txt, 1.txt, 2.txt и т. д.
      file_name = current_path + "/image/#{counter}.txt"

      if File.exist?(file_name)
        f = File.new(file_name, "r:UTF-8") # вторым параметром явно указываем на кодировку файла
        @status_image << f.read # добавляем все содержимое файла в массив
        f.close
      else
        @status_image << "\n [ изображение не найдено ] \n" # если файла нет, будет "заглушка"
      end

      counter += 1
    end
  end


  # Метод, рисующий виселицу. Ему достаточно знать сколько сделано ошибок, поэтому параметр метода,
  # не весь объект типа Game, а всего лишь число ошибок
  def print_viselitsa(errors)
    puts @status_image[errors] # все картинки мы загрузили в массив @status_image в конструкторе
  end


  # основной метод, печатающий состояния объекта класса Game,
  # который нужно передать в качестве параметра
  def print_status(game)
    cls
    puts "\nСлово: #{get_word_for_print(game.letters, game.good_letters)}"
    puts "\nОшибки: #{game.bad_letters.join(", ")}"

    print_viselitsa(game.errors)

    if game.status == -1
      puts "\nВы проиграли :(\n"
      puts "Загаданное слово было: " + game.letters.join("")
      puts
    elsif game.status == 1
      puts "Поздравляем, вы выиграли!\n\n"
    else
      puts "У вас осталось ошибок: " + (7 - game.errors).to_s
    end
  end

  # Служебный метод класса, возвращающий строку, изображающую загаданное слово

  def get_word_for_print(letters, good_letters)
    result = ""

    for item in letters do
      if good_letters.include?(item)
        result += item + " "
      else
        result += "__ "
      end
    end

    return result
  end

  def cls
    system "clear" or system "cls"
  end
end
