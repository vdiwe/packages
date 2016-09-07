#!/bin/sh
#
# COPYRIGHT (C) 2000-2010 SOFTWARE AG, INC. All rights reserved.
#

if [ "$1" = "" -o "$1" = "help" -o "$1" = "?" -o "$2" = "" -o "$3" = "" ] ; then
  echo Usage: createProjectArchive.sh eclipseLoc workspaceLoc projectName
  echo where eclipseLoc is the path of Eclipse location,
  echo workspaceLoc is the path of Eclipse workspace,
  echo and projectName is the name of rule project.
  echo Example: createProjectArchive.sh /opt/softwareag/eclipse/v36 myWorkspace myProject
  exit 1
fi

ECLIPSE_LOC=$1
WORKSPACE_LOC=$2
PROJECT_NAME=$3

java -cp "$ECLIPSE_LOC"/plugins/org.eclipse.equinox.launcher_1.1.0.v20100507.jar org.eclipse.core.launcher.Main -application org.eclipse.ant.core.antRunner -data "$WORKSPACE_LOC" -buildfile createProjectArchive.xml -Declipse.home="$ECLIPSE_LOC" -Dproject.name="$PROJECT_NAME"
