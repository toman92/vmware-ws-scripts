:: Demo batch file to delete a VM in Workstation 14 
:: Author: Sean Toman
:: Initial file: 08-MAR-18 
:: 15-MAR-18 : Changed paths to personal computer defaults

echo off
cls
title: VM Deletion Batch File
echo "*******************************************"
echo "This batch file will manipulate VMs in WS12"
echo "This is for demonstration purposes only."
echo "*******************************************"

setlocal

:: Set the path to where you are keeping the VM
set VMPATH=C:\Users\seant\Documents\Virtual Machines
::SET VMNAME=CO7-Clone
set /p VMNAME=Enter the name of the VM to delete - 

if exist "%VMPATH%\%VMNAME%\%VMNAME%.vmx" (
	echo Path to VM is %VMPATH%\%VMNAME%\%VMNAME%.vmx
) else (
	echo VM does not exist
	echo about to exit the script
	pause
	exit
)

set EXEPATH=C:\Program Files (x86)\VMware\VMware Workstation
echo Path to EXEs is %EXEPATH%

echo *** List running VMs ***
cd /D %EXEPATH%
vmrun list
pause

echo *** Stopping VM ***
vmrun stop "%VMPATH%\%VMNAME%\%VMNAME%.vmx"
vmrun list
echo *** Clone stopped ***
pause

echo *** Deleting VM ***
echo !!! About to remove all files from %VMPATH%\%VMNAME%
pause 
cd /D %VMPATH%\
rmdir %VMNAME% /S /Q
echo *** VM deleted ***
pause

:: Clean up
endlocal
cd %OneDrive%\College\Semester_4\Automation\Scripting_VMware

