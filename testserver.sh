export PODIP=$(kubectl get svc -o jsonpath='{.items[*].spec.ports[*].nodePort}')
echo $PODIP
for podi in $PODIP
do
echo $podi
status_code=$(curl -s -o /dev/null -w "%{http_code}" 192.168.99.102:$podi)
echo $status_code
if test $status_code == 200
then 
 echo "Working fine"
else
 echo " $status_code ERROR" 
 echo  "In Pod which nodeport is $podi"
 exit 0
fi
