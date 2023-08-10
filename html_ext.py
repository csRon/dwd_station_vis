#!/etc/python3

folder= "ger-cl-mon-kl-hist-new"
path = "./../../data/"
webfile = open("{}{}/filtered.html".format(path, folder), "r")
url_bas = "https://opendata.dwd.de/climate_environment/CDC/observations_germany/climate/monthly/kl/historical/monatswerte_KL_"

urls_file = open("{}{}/urls.txt".format(path, folder), "w")

for line in webfile:
	url_ind = line.split("KL_")[1].split("\">monatswerte")[0]
	url = url_bas + url_ind
	urls_file.write(url + "\n")

