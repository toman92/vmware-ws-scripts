:: Batch script to install vmware tool on to a guest OS, if it exists
:: Author: Sean Toman
:: Initial: 19-MAR-18

echo off
cls
title: Install VMware Tools
echo "*******************************************"
echo "This batch file will install VMware tools on a VM"
echo "It will first check if the VM exists, then check if"
echo "VMware tools are already installed"
echo "*******************************************"
echo.
echo.

:: Keep variables local to this script
setlocal

:: set path to virtual machines and ask user name of VM to check
set startpath=C:\Users\seant\Documents
set vmpath=C:\Users\seant\Documents\Virtual Machines
set exepath=C:\Program Files (x86)\VMware\VMware Workstation
set /p vmname=Please enter the name of the Virtual Machine - 

echo.
:: Check if VM is at given path
if exist "%vmpath%\%vmname%\%vmname%.vmx" (
	echo ...
) else (
	echo VM does not exist
	echo Closing script...
	pause
	exit
)

:: Change to directory vmrun.exe is located
cd /D %exepath%
:: Check if tools is installed. Direct output to file and store back into variable
echo *** VMTools Status ***
vmrun -T ws -gu sean -gp Sophia2015 checkToolsState "%vmpath%\%vmname%\%vmname%.vmx" > %startpath%\temp.txt
set /p state=<%startpath%\temp.txt

:: if contents of state is "installed" then don't install tools
if /I %state%==installed (
	echo Tools is already installed on %vmname%
	echo Exiting Script...
	pause
	exit
) else (
	echo Tools is NOT installed.
	set /p username=Please enter the username of the guest OS - 
	set /p password=Please enter the password of the guest OS - 
	echo About to install VMware Tools. Press [ctrl]+[C] if you wish to exit
	pause
	echo Installing VMware Tools....
	vmrun -T ws -gu %username% -gp %password% installTools "vmpath%\%vmname%\%vmname%.vmx"
	echo Install Finished...
	pause
)

:: Clean up
del %startpath%\temp.txt
endlocal
cd %OneDrive%\College\Semester_4\Automation
