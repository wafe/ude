@echo off
pushd "%~dp0"

if exist RedistPackages rd /s /q RedistPackages
if not exist RedistPackages\libs mkdir RedistPackages\libs
if not exist RedistPackages\symbols mkdir RedistPackages\symbols

set projectname=Ude
.nuget\nuget.exe pack src\Library\%projectname%.csproj -Build -Symbols -IncludeReferencedProjects -OutputDirectory "RedistPackages\libs" -Properties configuration=Debug

REM !!!!!!!!!! IMPORTANT
set libs_apikey=
REM !!!!!!!!!! IMPORTANT

for /f %%v in ('dir /b /s RedistPackages\libs\*.symbols.nupkg') do move %%v RedistPackages\symbols\
rem for /f %%v in ('dir /b /s RedistPackages\symbols\*.symbols.nupkg') do .nuget\nuget.exe push %%v -s http://xinics-packages/symbols/NuGet/ -ApiKey xxxx
for /f %%v in ('dir /b /s RedistPackages\libs\*.nupkg') do .nuget\nuget.exe push %%v -s http://xinics-packages/libs/ -ApiKey %libs_apikey%

start RedistPackages

:exit
popd
@echo on