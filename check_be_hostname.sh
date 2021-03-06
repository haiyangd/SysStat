BE_hostname_status=""
hFLAG=0
export GREEN='<font color="#00ff00">'
export RED='<font color="#ff0000">'
export NOC='</font>'
if [ "$1" = "slcn06vmf0021.us.oracle.com" ];then
#echo $1
IFS=$'\n'
for line in `cat /opt/SysStat/BE_sdi_mg_dc1.list`
do
    cd_dir=`echo $line | awk -F ";" '{print $1}'`
    java_cmd=`echo $line | awk -F ";" '{print $2}'`
    check_point=`echo $line | awk -F ";" '{print $3}'`
#    echo $cd_dir
#    echo $java_cmd
#    echo $check_point
    IFS=$' '
    BE_hostname=$(ssh root@${1} "$cd_dir && $java_cmd")
    IFS=$'\n'
    if [ "$BE_hostname" != "$check_point" ] ; then
        hFLAG="1"
        BE_hostname_status+="<li>$RED Command $java_cmd $NOC<ul><li>Expected result: $check_point</li><li>Actual result: $BE_hostname</li></ul></li>"
    else
        BE_hostname_status+="<li>$GREEN Command $java_cmd $NOC<ul><li>Expected result: $check_point</li><li>Actual result: $BE_hostname</li></ul></li>"
    fi
done
IFS=$' '
elif [ "$1" = "slce27vmf6011.us.oracle.com" ];then
IFS=$'\n'
for line in `cat /opt/SysStat/BE_sdi_edg_dc1.list`
do
    cd_dir=`echo $line | awk -F ";" '{print $1}'`
    export_cmd=`echo $line | awk -F ";" '{print $2}'`
    java_cmd=`echo $line | awk -F ";" '{print $3}'`
    check_point=`echo $line | awk -F ";" '{print $4}'`
#    echo $cd_dir
#    echo $java_cmd
#    echo $check_point
    IFS=$' '
    BE_hostname=$(ssh root@${1} "$cd_dir && $export_cmd && $java_cmd")
    IFS=$'\n'
    if [ "$BE_hostname" != "$check_point" ] ; then
        hFLAG="1"
        BE_hostname_status+="<li>$RED Command $java_cmd $NOC<ul><li>Expected result: $check_point</li><li>Actual result: $BE_hostname</li></ul></li>"
    else
        BE_hostname_status+="<li>$GREEN Command $java_cmd $NOC<ul><li>Expected result: $check_point</li><li>Actual result: $BE_hostname</li></ul></li>"
    fi
done
IFS=$' '

else
    hFLAG="0"
fi
#export BE_hostname_status
#export hFLAG
echo $BE_hostname_status
echo $hFLAG
