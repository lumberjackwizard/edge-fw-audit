Bash script utilized to audit the firewall logs on an NSX-T Edge log bundle. The script does the following:

1. Identifies all of the unique rule ids utilized in all of the firewall logs
2. For each rule id, finds the associated number of hits (i.e., how many times that rule has been logged)
3. Sorts the list of rule ids and their hits by hit count, from lowest to highest, and places it into an output file named 'fwrulehits.txt'
