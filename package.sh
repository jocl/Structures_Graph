#!/bin/bash
VERSION=`tla tree-version 2>&1 | sed "s/^.*\([0-9][0-9]*\.[0-9][0-9]*\)$/\1/g"`
TARGET_DIR=BUILD/
TARGET_DIRS=`find Structures -type d | grep -v .arch-ids`
mkdir -p $TARGET_DIR
./genpackage.xml.pl > BUILD/package.xml << EOF
<?xml version="1.0" encoding="ISO-8859-1" ?>
<package version="1.0">
 <name>Structures_Graph</name>
 <summary>Graph datastructure manipulation library</summary>
 <license>LGPL</license>
 <description>
 Structures_Graph is a package for creating and manipulating graph datastructures. It allows building of directed
 and undirected graphs, with data and metadata stored in nodes. The library provides functions for graph traversing
 as well as for characteristic extraction from the graph topology.
 </description>
 <maintainers>
  <maintainer>
   <user>sergio.carvalho</user>
   <name>S�rgio Carvalho</name>
   <email>sergio.carvalho@portugalmail.com</email>
   <role>lead</role>
  </maintainer>
 </maintainers>

 <release>
  <version>1.0.1</version>
  <date>2004-05-02</date>
  <state>stable</state>
  <notes>
  Version 1.0.1 fixes a bug in Node::connectTo
  </notes>
  <filelist>
FILESGOHERE
  </filelist>
 </release>
 <deps>
  <dep type="pkg" rel="ge" version="1.2">Pear</dep>
 </deps>
</package>
EOF
for dir in $TARGET_DIRS
do
    mkdir -p $TARGET_DIR/$dir
    cp `find $dir -type f -maxdepth 1 | grep -v .arch-ids` $TARGET_DIR/$dir
done
cp LICENSE BUILD
(cd BUILD; pear package)
rm -Rf BUILD/package.xml BUILD/LICENSE BUILD/Structures


