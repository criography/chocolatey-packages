# Chocolatey Packages

## Resources ##
https://github.com/chocolatey/choco/wiki  
http://unattended.sourceforge.net/installers.php  
http://www.migee.com/2010/09/24/solution-for-unattendedsilent-installs-and-would-you-like-to-install-this-device-software/  


## Handy shorthands ##
1. to test locally with dependencies:
choco install {{name}} -fdv -source "'$pwd;https://chocolatey.org/api/v2/'"
