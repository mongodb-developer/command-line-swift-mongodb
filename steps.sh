#!/bin/sh
# mlynn recreate basic env
echo "Enter project name: \c"
read PROJ
swift package init --name ${PROJ}
cat Package.swift.save | sed "s/___PROJECT___/${PROJ}/g"  > Package.swift
swift package update
swift build
