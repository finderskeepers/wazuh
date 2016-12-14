#!/bin/sh

# Wazuh Distribution Detector
# Copyright (C) 2016 Wazuh Inc.
# November 18, 2016.
#
# This program is a free software; you can redistribute it
# and/or modify it under the terms of the GNU General Public
# License (version 2) as published by the FSF - Free Software
# Foundation.

# Default values
DIST_NAME="Linux"
DIST_VER="0"
DIST_SUBVER="0"

# CentOS
if [ -r "/etc/centos-release" ]; then
    DIST_NAME="centos"
    DIST_VER=`sed -rn 's/.* ([0-9]{1,2})\.[0-9]{1,2}.*/\1/p' /etc/centos-release`
    DIST_SUBVER=`sed -rn 's/.* [0-9]{1,2}\.([0-9]{1,2}).*/\1/p' /etc/centos-release`

# Fedora
elif [ -r "/etc/fedora-release" ]; then
    DIST_NAME="fedora"
    DIST_VER=`sed -rn 's/.* ([0-9]{1,2}) .*/\1/p' /etc/fedora-release`

# RedHat
elif [ -r "/etc/redhat-release" ]; then
    DIST_NAME="redhat"
    DIST_VER=`sed -rn 's/.* ([0-9]{1,2})\.[0-9]{1,2}.*/\1/p' /etc/redhat-release`
    DIST_SUBVER=`sed -rn 's/.* [0-9]{1,2}\.([0-9]{1,2}).*/\1/p' /etc/redhat-release`

# Ubuntu
elif [ -r "/etc/lsb-release" ]; then
    . /etc/lsb-release
    DIST_NAME="ubuntu"
    DIST_VER=$(echo $DISTRIB_RELEASE | sed -rn 's/.*([0-9][0-9])\.[0-9][0-9].*/\1/p')
    DIST_SUBVER=$(echo $DISTRIB_RELEASE | sed -rn 's/.*[0-9][0-9]\.([0-9][0-9]).*/\1/p')

# Gentoo
elif [ -r "/etc/gentoo-release" ]; then
    DIST_NAME="gentoo"
    DIST_VER=`sed -rn 's/.* ([0-9]{1,2})\.[0-9]{1,2}.*/\1/p' /etc/gentoo-release`
    DIST_SUBVER=`sed -rn 's/.* [0-9]{1,2}\.([0-9]{1,2}).*/\1/p' /etc/gentoo-release`

# SuSE
elif [ -r "/etc/SuSE-release" ]; then
    DIST_NAME="suse"
    DIST_VER=`sed -rn 's/.*VERSION = ([0-9]{1,2}).*/\1/p' /etc/SuSE-release`
    DIST_SUBVER=`sed -rn 's/.*PATCHLEVEL = ([0-9]{1,2}).*/\1/p' /etc/SuSE-release`

# Arch
elif [ -r "/etc/arch-release" ]; then
    DIST_NAME="arch"
    DIST_VER=$(uname -r | sed -rn 's/.*([0-9]{1,2})\.[0-9].*/\1/p')
    DIST_SUBVER=$(uname -r | sed -rn 's/.*[0-9]{1,2}\.([0-9]).*/\1/p')

# Debian
elif [ -r "/etc/debian_version" ]; then
    DIST_NAME="debian"
    DIST_VER=`sed -rn 's/.*([0-9]{1,2})\.[0-9]{1,2}.*/\1/p' /etc/debian_version`
    DIST_SUBVER=`sed -rn 's/.*[0-9]{1,2}\.([0-9]{1,2}).*/\1/p' /etc/debian_version`

# Slackware
elif [ -r "/etc/slackware-version" ]; then
    DIST_NAME="slackware"
    DIST_VER=`sed -rn 's/.* ([0-9]{1,2})\.[0-9].*/\1/p' /etc/slackware-version`
    DIST_SUBVER=`sed -rn 's/.* [0-9]{1,2}\.([0-9]).*/\1/p' /etc/slackware-version`

# Darwin
elif [ "$(uname)" = "Darwin" ]; then
    DIST_NAME="darwin"
    DIST_VER=$(uname -r | sed -rn 's/.*([0-9]{1,2})\.[0-9].*/\1/p')
    DIST_SUBVER=$(uname -r | sed -rn 's/.*[0-9]{1,2}\.([0-9]).*/\1/p')

# Solaris / SunOS
elif [ "$(uname)" = "SunOS" ]; then
    DIST_NAME="sunos"
    DIST_VER=$(uname -r | cut -d\. -f1)
    DIST_SUBVER=$(uname -r | cut -d\. -f2)

# BSD
elif [ "X${UN}" = "XOpenBSD" -o "X${UN}" = "XNetBSD" -o "X${UN}" = "XFreeBSD" -o "X${UN}" = "XDragonFly" ]; then
    DIST_NAME="BSD ${NUNAME}."

elif [ "X${NUNAME}" = "XLinux" ]; then
    DIST_NAME="Linux"

fi