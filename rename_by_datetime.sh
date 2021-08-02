#!/bin/zsh

echo "Enter directory name: "
read directory
mkdir ${directory}_renamed

for filename in ${directory}/*; do
    extension=$(echo ${filename##*\.})
    
    datevar=`stat -f "%SB" "$filename"`
    datevar=$(sed 's/://g' <<< "$datevar")
    dateunits=$(echo $datevar | tr " " "\n")

    iter=0
    unit=("" "" "" "" "")
    for dateunit in $dateunits; do
        unit[${iter}]="$dateunit"
        iter=$(($iter+1))
    done

    string=""
    for i in 3 0 1 2; do
        if [ "$i" -eq 3 ]; then
            string="${unit[$i]}"
        elif [ "$i" -eq 0 ]; then
            case ${unit[$i]} in
            Jan) string="$string-01";;
            Feb) string="$string-02";;
            Mar) string="$string-03";;
            Apr) string="$string-04";;
            May) string="$string-05";;
            Jun) string="$string-06";;
            Jul) string="$string-07";;
            Aug) string="$string-08";;
            Sep) string="$string-09";;
            Oct) string="$string-10";;
            Nov) string="$string-11";;
            Dec) string="$string-12";;
            esac
        else
            string="$string-${unit[$i]}"
        fi
    done 

    string="$string.$extension"
    echo $string
    cp "$filename" "${directory}_renamed/$string"

done
