# smartclouds

git clone https://github.com/viruskingkk/smartclouds-laravel.git. 

laravel環境架設. 

sh laravelinit.sh. 

DB備份. 

sh DBbackup.sh. 

如要定時執行備份可加入crontab

RESTful API. 

python RESTful_API.py. 

Read:  
curl http://localhost:5000/user. 
Delete:  

curl http://localhost:5000/user -X DELETE -v. 
Create:  

curl http://localhost:5000/user -d "id=whoamI" -X POST -v. 
Update:  

curl http://localhost:5000/user



