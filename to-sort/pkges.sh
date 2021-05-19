while read line;
do
if [[ -z "$(__com1 | rg "$line")" ]]; then
    echo "$line" >> notbuilt;
else
    echo "$line" >> built
fi
done <<<"$(fd -u -t d -d 1 | estrip)"
