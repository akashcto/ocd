start=$(date +%F_%T | tr : -)
{
echo $start - start
time make 2>&1
echo $(date +%F_%T | tr : -) - end
} 2>&1 | tee build-$(date +%F_%T | tr : -).log
docker images
