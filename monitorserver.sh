htmlfiles= sudo ls /task3data/ | grep .html | wc -l
phpfiles= sudo ls /task3data/ | grep .php | wc -l

if $htmlfiles > 0
then 
if sudo kubectl get deployment | grep webserver
then
echo "webserver setup already running"
else
sudo kubectl apply -f webserver.yaml
fi
else
echo "No files so no nedd for set up"
fi
POD=$(sudo kubectl get pods -l app=webserver -o jsonpath="{.items[0].metadata.name}")
cd /task3data/
sudo kubectl cp /task3data/index.html $POD:/usr/local/apache2/htdocs/

if $phpfiles > 0
then 
if sudo kubectl get deployment | grep php
then
echo "php setup already running"
else
cd
cd /home/jenkins
sudo kubectl apply -f phpserver.yaml
fi
else
echo "No files so no nedd for set up"
fi
POD=$(sudo kubectl get pods -l app=php -o jsonpath="{.items[0].metadata.name}")
cd /task3data/
sudo kubectl cp /task3data/index.php $POD:/var/www/html
