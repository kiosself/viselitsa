
# Класса, отвечающий за ввод данных в программу "виселица"
class WordReader

  def read_from_args
    return ARGV[0]
  end

  # Метод, возвращающий случайное слово, прочитанное из файла,
  # имя файла передается как аргумент метода
  def read_from_file(file_name)
    # проверка, если файла не существует, сразу возвращаем nil
    if !File.exist?(file_name)
      return nil
    end

    f = File.new(file_name, "r:UTF-8") # открываем файл, явно указывая его кодировку
    lines = f.readlines
    f.close

    return lines.sample.chomp

  end
end