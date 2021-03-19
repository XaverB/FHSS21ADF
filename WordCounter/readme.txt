Wörter mit höchster Frequenz suchen
cat INPUT.txt |tr ' ' '\n' |sort |uniq -c | sort | wc -l

Duplikate zählen (Gesamtanzahl der Wörter Count > 1):
 grep -wo '[[:alnum:]]\+' Kafka.txt | sort | uniq -d -c | awk -F'[^0-9]*' '/[0-9]/ { print ($1 != "" ? $1 : $2) }' | wc -l


 grep -wo '[[:alnum:]]\+' Kafka.txt | sort | uniq -d -c | wc -l