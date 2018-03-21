:: Demo batch file to configure a VM in Workstation 12 
:: Author: Sean Toman
:: Initial file: 08-MAR-18 
:: 15-MAR-18 : Changed paths to personal computer defaults

echo off
cls
title: VM Configuration Batch File
echo "*******************************************"
echo "This batch file will manipulate VMs in WS12"
echo "This is for demonstration purposes only."
echo "*******************************************"
echo This command file will not work unless VMware tools are installed on the VM
echo run InstallTools.cmd to install VMware tools 

setlocal

:: Set the path to where you are keeping the VMs
set VMPATH=C:\Users\seant\Documents\Virtual Machines
set /p VMNAME=Enter the name of the Virtual Machine - 
if exist "%VMPATH%\%VMNAME%\%VMNAME%.vmx" (
	echo Path to VM is %VMPATH%\%VMNAME%\%VMNAME%.vmx
) else (
	echo VM does not exist
	echo about to exit the script
	pause
	exit
)

set EXEPATH="C:\Program Files (x86)\VMware\VMware Workstation"
echo Path to EXEs is %EXEPATH%

echo *** List running VMs ***
cd /D %EXEPATH%
vmrun list
pause

:: Checks if VMware tools is installed. Pass guest username and password
echo *** VMTools Status ***
vmrun -T ws -gu root -gp Passw0rd checkToolsState "%VMPATH%\%VMNAME%\%VMNAME%.vmx"
pause

echo *** Test a command"
vmrun -T ws -gu student -gp Passw0rd runScriptInGuest "%VMPATH%\%VMNAME%\%VMNAME%.vmx" /bin/bash "touch /home/student/WooHoo"
::vmrun -T ws -gu root -gp Passw0rd runProgramInGuest %VMPATH%\%VMNAME%\%VMNAME%.vmx /bin/date
::pause

:: Clean up
endlocal
cd %OneDrive%\College\Semester_4\Automation\Scripting_VMware