#!/bin/bash

# This script shall be called by DelugeD in the "On torrent added" action

PwD=$(readlink -e $0)	# Get the path to this script
PwD=$(dirname "$PwD")
db="$PwD/labelsOfTorrents.db"

# get arguments from DelugeD
torrentid=$1
torrentname=$2
torrentpath=$3

#echo "Date:		`date`" >> "$PwD/log"
#echo "TorrentID:	$torrentid" >> "$PwD/log"
#echo "TorrentName:	$torrentname" >> "$PwD/log"
#echo "TorrentPath:	$torrentpath" >> "$PwD/log"
#echo "I am:		`whoami`" >> "$PwD/log"
#echo "" >> "$PwD/log"

if (( $# == 0 )); then							# no arguments!?
	exit 1;
fi

if [ -n "$(grep $torrentid $db)" ]; then		# torrent already exists
	exit;
fi

echo "$(date +%s) deluge $torrentid $torrentname " >> $db

