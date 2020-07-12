export PODIP=$(kubectl get svc -o jsonpath='{.items[0].spec.ports[0].nodePort}')
echo $PODIP
export status_code=$(curl -s -o /dev/null -w "%{http_code}" 192.168.99.102:$PODIP)
echo $status_code
if $status_code == 200
then 
 echo "webpage is working properly"
 exit 1
else
 echo " $status_code this is the not the webpage you are looking for" 
 exit 0
fi
