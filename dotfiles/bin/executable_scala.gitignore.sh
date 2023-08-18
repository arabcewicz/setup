#!/bin/sh
cat << EOF >> .gitignore
# bloop and metals
.bloop
.bsp
.metals
project/metals.sbt

# vs code
.vscode

# scala 3
.tasty

# sbt
project/project/
project/target/
target/

# eclipse
build/
.classpath
.project
.settings
.worksheet
bin/
.cache

# intellij idea
*.log
*.iml
*.ipr
*.iws
.idea

# mac
.DS_Store

# other?
.history
.scala_dependencies
.cache-main

# general
*.class
EOF