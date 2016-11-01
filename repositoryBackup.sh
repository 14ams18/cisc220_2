
#!/bin/bash
#Abigael Schonewille       10176344
#Connor Way                10192779
# * 1 * * * >> backupsLog 
#local repository must have the same name as the global repository
#only needs the input of the local repository, username, password
cd ~
cd $1
day=$(date +%d)
month=$(date +%m)
year=$(date +%Y)
hour=$(date +%H)
date=$year$month$day$hour
tar -zcvf backup$date.tgz *
if [[ -e backup$date.tgz ]]; then
	echo "Backup backup$date.tgz created successfully!"
fi
git config --global user.name $2
git config --global user.password $3
git pull 
adding=$(git add backup$date.tgz)
git commit
if [[ $adding -eq 0 ]]; then
	echo "Backup backup$date.tgz committed to the local git repository"
fi
pushing=$(git push https://$2:$3@github.com/$2/$1.git backup$date.tgz)
if [[ $pushing -eq 0 ]]; then
	echo "Backup backup$date.tgz pushed to the remote git repository $1"
fi

