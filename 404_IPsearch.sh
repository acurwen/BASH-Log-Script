#!/bin/bash

#Checking log files for 404 errors & providing the number of times each IP encountered a 404 error.

#Creating files to hold each output
#Main file
source_file="/home/ubuntu/Class_Scripts/web-server-access-logs.log"

#File to hold log lines with 404 errors only
dest_file="/home/ubuntu/Class_Scripts/404error.txt"

#File to hold only the IPs of the 404 error log lines
IPs_file="/home/ubuntu/Class_Scripts/IPs.txt"

#File to hold the output of IPs and their occurrences
counter="/home/ubuntu/Class_Scripts/HI.txt"


#Search the main log file for all occurrences of 404 Status Code and print them to new file
cat "$source_file" | grep " 404 " > "$dest_file"

#Isolating IPs associated with the 404 lines and printing them to new file
awk -F ',"' '{print $2}' "$dest_file" | awk -F ' - - ' '{print $1}' > "$IPs_file"

#Counting the number of times each IP encountered a 404.
sort "$IPs_file" | uniq -c > "$counter"

echo "Below is the number of times each IP address encountered a 404 error:"
cat "$counter"
