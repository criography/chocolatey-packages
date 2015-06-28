# Chocolatey Packages

## Resources ##
https://github.com/chocolatey/choco/wiki  
http://unattended.sourceforge.net/installers.php  
http://www.migee.com/2010/09/24/solution-for-unattendedsilent-installs-and-would-you-like-to-install-this-device-software/  
http://wpkg.org/index.php?title=Category:Silent_Installers&pagefrom=FlashShock
http://appsnap.googlecode.com/svn/trunk/appsnap/db.ini

## Handy shorthands ##
1. to test locally with dependencies:
choco install {{name}} -fdv -source "'$pwd;https://chocolatey.org/api/v2/'"
