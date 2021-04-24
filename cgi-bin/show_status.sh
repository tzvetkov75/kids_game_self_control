#!/bin/bash

printf "Content-type: text/html\n\n"

echo """
<!DOCTYPE HTML>
<html lang="de">
<link rel="stylesheet" href="/w3.css">
<body>
"""
bin/api_command.sh all status |  grep '<table id="uiProfileList"'
echo """
</body>
</html>
"""
