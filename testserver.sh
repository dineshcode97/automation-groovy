export pod_ip=$(kubectl get svc -o jsonpath='{.items[*].spec.ports[*].nodePort}')
echo $pod_ip
export status_code=$(curl -s -o /dev/null -w "%{http_code}" 192.168.99.102:$pod_ip)
echo $status_code
if test $status_code -eq 200
then 
 echo "Working Fine"
 exit 1
else
 echo " $status_code ERROR" 
 exit 0
fi
