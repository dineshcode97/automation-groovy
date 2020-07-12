ips=$(kubectl get svc -o jsonpath='{.items[*].spec.ports[*].nodePort}')
echo $ips
for ip in $ips
do
if test $ip == 31136
then
echo ""
else
status_code=$(curl -s -o /dev/null -w "%{http_code}" 192.168.99.102:$ip)
echo $status_code
if test $status_code == 200
then 
 echo "Working Fine"
 exit 1
else
 echo " $status_code ERROR" 
 exit 0
fi
fi
done
