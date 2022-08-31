#!/bin/bash

### VARIABLE ###
source_to_find="$1"
target_to_find="$2"
primo=0
secondo=0
source_to_find=$(echo "$1" |awk '{print tolower($0)}') #4 works need lowercase
target_to_find=$(echo "$2" |awk '{print tolower($0)}') #4 works need lowercase

function VARIABLE_CHECK() {
	printf "\n"
	printf "\n"
	if [ -z "$source_to_find" ]; then
		echo "source variable is not set"
		primo=1
	fi
	if [ -z "$target_to_find" ]; then
		echo "target variable is not set"
		secondo=1
		printf "\n"
	fi
	if [ "$primo" == 1 ] || [ "$secondo" == 1 ]; then
		echo "need to use => command "'$1'" "'$2'" <="
		echo "example => command GBP EUR"
		printf "\n"
		exit
	fi
}

function RECOVER() {
	echo -e "loading in progress.."
	rate=$(curl -H 'user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/104.0.0.0 Safari/537.36' -s https://wise.com/us/currency-converter/$source_to_find-to-$target_to_find-rate |grep "currentRate" |tail -n 1 |cut -d: -f2 |tr -d '",' |awk '{print $3}' |tr -d ";")
	source=$(curl -H 'user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/104.0.0.0 Safari/537.36' -s https://wise.com/us/currency-converter/$source_to_find-to-$target_to_find-rate |grep "source" |tail -n 1  |cut -d: -f2 |tr -d '",' |awk '{print $3}' |tr -d ";")
	target=$(curl -H 'user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/104.0.0.0 Safari/537.36' -s https://wise.com/us/currency-converter/$source_to_find-to-$target_to_find-rate |grep "target" |tail -n 1 |cut -d: -f2 |tr -d '",' |awk '{print $3}' |tr -d ";")
	echo -e "done!!"
}

function SHOW() {
	printf "\n"
	#printf "\n"
	#echo -e "source => $source"
	#echo -e "rate   => $rate"
	#echo -e "target => $target"
	#printf "\n"
	echo -e "1 $source = $rate $target"
	printf "\n"
}



### MAIN ###
VARIABLE_CHECK
RECOVER
SHOW
