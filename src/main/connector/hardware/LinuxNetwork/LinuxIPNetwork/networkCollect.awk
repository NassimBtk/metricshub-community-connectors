BEGIN {
	transmitPackets = ""
	transmitErrors = ""
	receivePackets = ""
	receiveErrors = ""
	transmitBytes = ""
	receiveBytes = ""
}

# ip a
$1 ~/^[0-9]+:/ && $2 ~ /^.*:/ {
	deviceID = $2
	gsub(":", "", deviceID)
}

$1 ~ /RX:/ && $2 ~ /bytes/ && $3 ~ /packets/ {
	getline
	receiveBytes = $1
	receivePackets = $2
	receiveErrors = $3
}

$1 ~ /TX:/ && $2 ~ /bytes/ && $3 ~ /packets/ {
	getline
	transmitBytes = $1
	transmitPackets = $2
	transmitErrors = $3
}

END {
	print "MSHW;" deviceID ";" receivePackets ";" transmitPackets ";" (receiveErrors + transmitErrors) ";" receiveBytes ";" transmitBytes
}