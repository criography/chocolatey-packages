# ====================================================
# GetMenuStartPath
# ====================================================
# Grabs Menu Start location from registry.
#
# @return   {string}    Menu Start path
# ====================================================

Function GetMenuStartPath(){
  return (Get-ItemProperty -Path "Registry::HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders")."Start Menu"
}



