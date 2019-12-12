#!/bin/bash

# автор: Рамиль Сафин
# группа: 11-831
# вариант: 1

guessed_right=0
guessed_wrong=0

while [[ true ]]; do
	rnd=$(shuf -i 0-9 -n 1)
		
	read -p "Какое число от 0 до 9 загадано сейчас (q - закончить)?: " input

	[[ "${input}" == 'q' ]] && { echo "Все, ухожу!"; exit 0; }

	[[ "${input}" =~ ^[0-9]$ ]] || { echo "Введите корректное число от 0 до 9!"; continue; }

	if (( "${input}" == rnd )); then
		guessed_right=$((guessed_right+1))
		echo "Угадали!"
	else
		guessed_wrong=$((guessed_wrong+1))
		echo "Не повезло!"
	fi

	rnd_hist+=( $rnd )

	guessed_right_percent=$((guessed_right*100/(guessed_right+guessed_wrong)))

	echo "Статистика (уагадано/ не угадано): ${guessed_right_percent}% / $((100-guessed_right_percent))%"
	echo "Загаданные числа: ${rnd_hist[@]}"

done