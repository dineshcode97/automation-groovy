export PODIP=$(kubectl get svc -o jsonpath='{.items[*].spec.ports[*].nodePort}')
echo $PODIP
for podi in $PODIP
do
export status_code=$(curl -s -o /dev/null -w "%{http_code}" 192.168.99.102:$podi)
echo $status_code
if $status_code == 200
then 
 echo "Working fine"
 exit 1
else
 echo " $status_code ERROR" 
 exit 0
fi
done
