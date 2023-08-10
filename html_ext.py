#!/etc/python3

import sys

filepath = sys.argv[1]
url_base = sys.argv[2] + "monatswerte_KL_"

webfile = open("{}/filtered.html".format(filepath), "r")

urls_file = open("{}/urls.txt".format(filepath), "w")

for line in webfile:
	url_ind = line.split("KL_")[1].split("\">monatswerte")[0]
	url = url_base + url_ind
	urls_file.write(url + "\n")

