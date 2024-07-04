#!/bin/bash

# script created to run through all of the firewall logs recorded on the edge
# identifying the count of hits per rule id and then sorting those based on hit count


dfw_dir="NSXT_EdgeNode_nsx-en01_10.238.0.74_20240701T185527Z/var/log/"

# grab the rule id number from each dfwpacketlog line item
# removing 'message repeated' entries in the firewallpkt.logs 

fwrules=$(cat $dfw_dir/firewallpkt.log* | grep -v "message repeated" | cut -d " " -f16 | sort -u)

# Searching for the  firewall ID and showing the result of counts in a local file
# had to include a regex for either PASS or DROP to ensure that the matching data wouldn't be found in other parts of the line, such as a port number

echo "Processing firewall log data. This may take a few minutes..."

for n in $fwrules; do echo -n "Firewall entries for rule $n : " ; grep '\(PASS\|DROP\)\s'$n'\s' $dfw_dir/firewallpkt.log* |  wc -l ; done  > fwrulehitstemp.txt

#sorting the original file and placing the content into a new file

cat fwrulehitstemp.txt | sort -k7 -h > fwrulehits.txt

echo "Output file is located at" `pwd`"/fwrulehits.txt"

# removing temp file

rm fwrulehitstemp.txt
