#!/bin/bash
printf "Content-type: text/html\n\n"

./show_status.sh | html2text
