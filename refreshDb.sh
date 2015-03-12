#!/bin/bash


# This script refreshes all labels from the torrent clients

delugeLabels="/etc/deluged/label.conf"		# Path to label.conf in DelugeD conf dir
deadline="2 months"							# `date -d` compatible time interval


PwD=$(readlink -e $0)	# Get the path to this script
PwD=$(dirname "$PwD")
db="$PwD/labelsOfTorrents.db"


if [ ! -f "$db" ]; then									# db does not exist
	echo "DB does not exist!" >&2
	exit 1;
fi
if [ -n "$delugeLabels" -a ! -f "$delugeLabels" ]; then
	echo "label.conf not found at $delugeLabels" >&2
	exit 1;
fi

deadline=$(date +%s -d "-$deadline")					# get timestamp of deadline
#echo $deadline

touch $db.tmp
while IFS=' ' read -r  time daemon id name label; do	# read DB

	if [ $time -gt $deadline ]; then					# if entry is not too old

		case $daemon in
		deluge)
			labelNew=$(grep -m 1 $id $delugeLabels | grep -o ': ".*"' | grep -o '[a-zA-Z0-9_-]*')		# get label from Deluge
			;;
		*)
			echo "Unknown daemon $daemon!" >&2
			exit 2
			;;
		esac

		if [ -n "$labelNew" ]; then
			label=$labelNew;							# set label
		fi

		#echo $time $daemon $id $name $label
		echo $time $daemon $id $name $label >> $db.tmp;	# keep in db
	#else
		#echo skipped $time $daemon $id $name $label
	fi
done < $db;

mv $db.tmp $db
chmod 666 $db
