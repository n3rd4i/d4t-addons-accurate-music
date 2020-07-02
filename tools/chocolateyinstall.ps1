$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
. "$toolsDir\commonEnv.ps1"

$url = Get-ModdbDlUrl 'https://www.moddb.com/addons/start/174491'
$unzipLocation = "$(Join-Path $toolsDir music)"
$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $unzipLocation
  url           = $url
  checksum      = '6F3D92CBEE24DC5009C323F83B919D9DEC187FE14D84134DD46B4353020CC0C0'
  checksumType  = 'sha256'
}
Install-ChocolateyZipPackage @packageArgs

# Cleanup link first (safely)
& $ENV:COMSPEC /C IF EXIST $wad_lnk DEL /S /Q $wad_lnk

# Install symbolic link for later use
$wad_src = "$(Join-Path $unzipLocation $wad)"
& $ENV:COMSPEC /C MKLINK $wad_lnk $wad_src
