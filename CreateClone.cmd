:: Demo batch file to create a VM in Workstation 12 
:: Author: Sean Toman
:: Initial file: 08-MAR-18
:: 15-MAR-18 : Changed paths to personal computer defaults

echo off
cls
title: VM Creation Batch File
echo "*******************************************"
echo "This batch file will manipulate VMs in WS12"
echo "This is for demonstration purposes."
echo "*******************************************"

setlocal

:: Set the path to where you are keeping the VMs
set VMPATH=C:\Users\seant\Documents\Virtual Machines
set /p VMNAME=Enter the name of the original VM - 
if exist "%VMPATH%\%VMNAME%\%VMNAME%.vmx" ( 
	echo Path to VM is %VMPATH%\%VMNAME%\%VMNAME%.vmx 
) else ( 
	echo VM does not exist, script cannot complete 
	echo about to exit the script 
	pause 
	exit 
)

:: Set the path to where you are keeping the Clone
set /p CLONENAME=Enter the name of the clone - 
echo Path to Clone is %VMPATH%\%CLONENAME%\%CLONENAME%.vmx

:: Set the path to where you are keeping the EXE files
set EXEPATH="C:\Program Files (x86)\VMware\VMware Workstation"
echo Path to EXEs is %EXEPATH%

echo *** List running VMs ***
cd /D %EXEPATH%
vmrun list

pause

:: Gives user chance to quit before cloning 
echo About to clone %VMNAME%, press [ctrl][c] to exit
pause

echo *** Clone "%VMPATH%\%VMNAME%\%VMNAME%.vmx" to "%VMPATH%\%CLONENAME%\%CLONENAME%.vmx" ***
vmrun clone "%VMPATH%\%VMNAME%\%VMNAME%.vmx" "%VMPATH%\%CLONENAME%\%CLONENAME%.vmx" linked

:: Give user chance to quit before starting the clone
echo About to start %CLONENAME% exit
pause
vmrun start "%VMPATH%\%CLONENAME%\%CLONENAME%.vmx"
::vmrun start "%VMPATH%\%CLONENAME%\%CLONENAME%.vmx" nogui      

vmrun list
echo *** Clone created and started ***
pause

:: Clean up
endlocal
cd %OneDrive%\College\Semester_4\Automation