#!/bin/bash

# ./log_analyzer.sh log . ERROR - запуск команды со всеми аргументами

# Проверяем, передано ли расширение файла
# Если передано - устанавливаем расширение файла, по которому будем производить поиск
if [[ -z "$1" ]]; then
  echo "Не передан обязательный аргумент! Укажите расширение файла, по которому будем производить поиск"
  exit 1
else
  fileExtension="$1"
fi

# Проверяем, передан ли путь до директории, в которой будем искать файлы
# Если путь не передан, будем искать в текущей
if [[ -n "$2" ]]; then
  dirPath=$2
else
  dirPath="./logs"
fi

# Проверяем, передано ли путь ключевое слово, которое будем искать в файлах
# Если нет, устанавливаем ключевое слово по-умолчанию (ERROR)
if [[ -n "$3" ]]; then
  word=$3
else
  word="ERROR"
fi

# Переменная для подсчета общего кол-ва строк для всей директории
total=0

# Проверяем существует ли указанная директория
if [[ ! -d "$dirPath" ]]; then
  echo "директория $dirPath не существует"
  exit 0
fi

# Получаем список файлов в директории и складываем их в массив
files=( $(find "$dirPath" -name "*.$fileExtension") )

# Проверяем, нашлись ли файлы с указанным расширением в директории
if [[ ${#files[@]} -eq 0 ]]; then
  echo "Файлы с расширением $fileExtension не найдены в директории $dirPath"
  exit 0
fi

# Проходим по массиву с файлами
for file in "${files[@]}"; 
do 
	# Находим все строки с ключевым словом в файле и складываем их в массив lines
	lines=( $(grep "$word" "$file") )

  # Считаем общее кол-во строк для всей директории
	total=$((total + ${#lines[@]}))

	# Выводим название файла и кол-во строк с ключевым словом
	echo "Файл $file содержит ${#lines[@]} строк с ключевым словом $word"
done

echo "Общее количество строк - $total"