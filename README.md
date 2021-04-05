# Self control for internet access for kids 
## How it works 

**This is a prototype. Do NOT expect working product**

The kid receives contingent of several hours on the internet for the  week. The contingent (accumulated time) can be distributed over different devices by the kid (self control).
The kid can control the internet on different devices, like phone or PS4. It is possible to set timer for how long the internet is active (timer) or manually switch it on and off. Every weeka new contingent of play minutes (time) is loaded to the exiting value via cronjob 

## Preconditions

- Using AVM Fritz Box router and currently two profiles - one for PS4 and one for Phone (or any two)
- Web server in your home network supporting CGI, UNIX(BASH).For be this was NAS server 
-  *at* and *atq* unix command, for debian *apt-get install at*

## Install 

- Edit ./cgi-bin/bin/avm_cred.sh to correspond to your credentials and IP
- Edit if needed  ./cgi-bin/bin/\*_stop.sh and \*_start.sh to correspond to your profile controls URLS. You can get the commands  by exemining with browser dev tools (network) when you manually activate internet on the profile. Currenlty AVM Firtz!Box curls for profiles PS4,Kinder   
- Edit ./cgi-bin/bin/init.sh to set the  weekly allowed time 
- execute ./cgi-bin/bin/init.sh to set the values 
- set cronjob to run the init.sh evey week to charge the profile with init script. For example (fix the dir) 
`5 5 * * 1 cd /usr/lib/cgi-bin/ && ./bin/init.sh` 
- allow the httpd deamon user, like apache, to execute *at* command, aka add user, ile www-data, to */etc/at.allow* 
done 

## What is next (TBD)

- (FEATURE) Support more devices 
- (IMPROVEMENT) the folder structure 
- (IMPROVEMENT) Securty of cred file
- (BUG) UI disable buttons ones clicked (dubble click(
- (FEATURE) Package is with thiny server - all in one 
- (IMPROVEMENT) sync status between the router and application: out of sync problem
- (FEATURE) CGI script errors output missing 
- (BUG) test cases 
