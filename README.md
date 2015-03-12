# Torrent-Label-DB
A text database which contains torrent names and labels

This DB is used by Jonny007-MKD/OTR-DecodeAll to retreive labels set in the Torrent client by the filename.

An entry is added by the torrent client by calling a special script after adding the torrent.
The refresh script walks through all entries and fetches the label from the torrent client.

Supported torrent clients:
	- Deluge (http://deluge-torrent.org/). Call `delugeAddTorrent.sh` with Action `Torrent Added` in Plugin `Execute`
	- I'd love to add more clients. Please participate!

Possible problems:
	- It works for single file torrents. Something else was not tested.
