# BASH-Log-Script

Task: Create a BASH script that will search the log file for "404" errors and identify the IP addresses associated with them.  Then provide the number of times each IP encountered a 404.

## Isolating lines with 404 status codes
First, tested grep command in script to see if lines with " 404 " (indicating the 404 status code) would show up. This worked.
![image](https://github.com/user-attachments/assets/73b3d075-dddb-4442-8780-d1d1d226f5a6)

Then tested appending that output to a new file named 404error.txt. This worked.
![image](https://github.com/user-attachments/assets/7c1a5790-1ee2-4b61-8a24-fc5ca2fa9421)

Result:
![image](https://github.com/user-attachments/assets/32463ac5-b995-46e8-a94d-e3987d5105a8)

## Isolating IPs of the lines with the 404 status codes
Next, I wanted to isolate the IPs from these lines using the awk command.

Ran `awk -F ',"' '{print $2}' 4.txt` in the terminal and it worked, however, after the IP, the output also included the rest of the line. (4.txt is a test file that holds all the "404" error codes.)

Output:
![image](https://github.com/user-attachments/assets/dc23d664-884b-4d30-ac8f-5e49197e90ee)


This is because the field separator I used in the awk command `',"'` is not the same separator between the IP addresses and the next part of the line. Instead it's `' - - '`.

Example:
![image](https://github.com/user-attachments/assets/fa327c49-3270-4e28-8716-51953230d1e0)

So I combined the two awk commands into a pipe and ran `awk -F ',"' '{print $2}' 4.txt | awk -F ' - - ' '{print $1}'` and was able to isolate the IPs.

Snippet of Output:
![image](https://github.com/user-attachments/assets/afe0b505-823f-4636-a0bb-5b167bd29bbc)

Tested this command to output to a file called IPs.txt and it worked, so I added that to my script. 

![image](https://github.com/user-attachments/assets/fd7e22db-4dd8-425a-80a1-4a0fbe3a12f8)

## Counting the number of times each IP encountered a 404.

Searched how to check for duplicates in BASH and found the sort and uniq commands that can be used like this: `sort filename | uniq -d`.
The `uniq` '-d' flag will output all duplicate occurences and the `uniq` '-c' flag will count the occurence and will print it with the output. Since I need the count of how many times an IP address encountered a 404 I used the -c flag.
Tested `sort IPs.txt | uniq -c` in my terminal and it worked. 

Snippet of Output:

![image](https://github.com/user-attachments/assets/a161d64e-a1f1-47f8-a60c-ac17042b1fe6)

Added this line in my script, but appended the output to yet another file. I tried echoing just that line, but the terminal only printed the path to my file which makes sense. 

So I added in an echo message to preface the output and ended the script with a cat command.

![image](https://github.com/user-attachments/assets/9539a339-598d-4f50-b9aa-789ae1da791e)

Ideas for optimizing this script would be to overwrite the files' inputs with `>>` everytime the script is run to eliminate duplicates and get an accurate output, or figure out a way to update the same file throughout each section of the script so I don't have so many file variables. Can also use a while loop to check if the file is empty before writing to it.

***Reviewing the instructions and seeing that we need to include a loop or conditional. Next time I could have done an if conditional testing if any of the three files were empty before copying anything into them to avoid duplicates. To do this I could write `if [ -s "$counter" ]` as my condition. 
