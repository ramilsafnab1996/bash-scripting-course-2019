#!/bin/bash

reference_stack=( {8..1} )
stack_1=( {8..1} )
stack_2=()
stack_3=()

step=1

function show_stacks() {
	echo "1) ${stack_1[*]}"
	echo "2) ${stack_2[*]}"
	echo "3) ${stack_3[*]}"
}

# takes 2 arguments: source and target stacks
# moves the top element from the source to the target stack
# the top element of the target stack must be less than the source stack ones
function move() {
	local -n src_stack=$1
	local -n target_stack=$2

	if (( ${#src_stack[@]} )); then # source is not empty

		if (( ${#target_stack[@]} )) && (( ${src_stack[-1]} < ${target_stack[-1]} )) || (( !${#target_stack[@]} )); then # source element is less than the target top element, or empty target
			target_stack+=(${src_stack[-1]})
			unset src_stack[-1]
		else
			echo "Перемещение запрещено!"
		fi
	fi
}

echo "Игра начинается. Так выглядит стек:"
show_stacks

while [[ true ]]; do
	read -p "Ход №${step} (откуда, куда): " src dst

	[[ "${src}" == 'q' ]] && { echo "Все, ухожу!"; exit 0; }

	[[ "${src}" =~ ^[1-3]$ ]] || { echo "Введите корректные номера стеков: от 1 до 3!"; continue; }
	[[ "${dst}" =~ ^[1-3]$ ]] || { echo "Введите корректные номера стеков: от 1 до 3!"; continue; }

	case "${src}-${dst}" in
		"1-2" )
			move stack_1 stack_2
			;;
		"1-3" )
			move stack_1 stack_3
			;;
		"2-1" )
			move stack_2 stack_1
			;;
		"2-3" )
			move stack_2 stack_3
			;;
		"3-1" )
			move stack_3 stack_1
			;;
		"3-2" )
			move stack_3 stack_2
			;;
		* )
			;;
	esac

	step=$((step+1))
	show_stacks

	if [[ "${stack_2[@]}" == "${reference_stack[@]}" || "${stack_3[@]}" == "${reference_stack[@]}" ]]; then
		echo "Победа!"
		exit 0
	fi

done
