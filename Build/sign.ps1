# Install signtool.exe
# https://go.microsoft.com/fwlink/?LinkID=698771


$CertPath = 'C:\CodeCert\23092018.NOTORAApS.pfx';
$SignToolPath = 'c:\Program Files (x86)\Windows Kits\10\bin\x64\signtool.exe'
$Password = Get-Content C:\CodeCert\password.txt

foreach ($filename in Get-ChildItem .) 
{
    if ($filename -match ".*\.app")
    {
        Write-Host "Signing " $filename
        & $SignToolPath sign /f $CertPath /p $Password /t http://timestamp.verisign.com/scripts/timestamp.dll $filename
    }
}
