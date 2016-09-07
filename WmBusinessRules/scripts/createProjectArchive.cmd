@REM
@REM COPYRIGHT (C) 2000-2010 SOFTWARE AG, INC. All rights reserved.
@REM

echo off

if "%1" == "" goto Usage
if "%1" == "help" goto Usage
if "%1" == "?" goto Usage

if "%2" == "" goto Usage
if "%3" == "" goto Usage

set ECLIPSE_LOC=%1
set WORKSPACE_LOC=%2
set PROJECT_NAME=%3

java -cp "%ECLIPSE_LOC%"/plugins/org.eclipse.equinox.launcher_1.1.0.v20100507.jar org.eclipse.core.launcher.Main -application org.eclipse.ant.core.antRunner -data "%WORKSPACE_LOC%" -buildfile createProjectArchive.xml -Declipse.home="%ECLIPSE_LOC%" -Dproject.name="%PROJECT_NAME%"
goto Done

:Usage
echo Usage: createProjectArchive.cmd eclipseLoc workspaceLoc projectName
echo where eclipseLoc is the path of Eclipse location,
echo workspaceLoc is the path of Eclipse workspace,
echo and projectName is the name of rule project.
echo Example: createProjectArchive.cmd C:\SoftwareAG\eclipse\v36 C:\myWorkspace myProject

:Done
