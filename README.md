How to maintain syscheck_daemon How to maintain syscheck_daemon syscheck_daemon
For Monitoring Multiple SDI Linux servers (Network /Uptime/Current CPU /Average Daily CPU /Total Processes /Ram + Swap/Processes Check /SDI Status) from a single machine , implemented as a daemon 
steps to configure (recommended to run these as sudo or root)

1 Update User and hostnames (U can add multiple hosts && after installation configuration is picked up from under /opt/SysStat/r_systat.config)
r_systat.config
export Q_HOST="slcn06vmf0021.us.oracle.com slce27vmf6011.us.oracle.com"
#List Of hosts to be monitored
# SSH USER, change me ####Common User 
export USR="root"
# -- Show warning if server load average is below the limit for last 5 minute
export LOAD_WARN=16.0 #####CPU Load More than
export MEM_WARN=1 ###### Memory Less than 1Gb
export SWAP_WARN=90 ######### SWAP more than 90%
export STIME=600 
export NETVAL=30 ########check after 30sec if a machine is down 
export LOGDEST="/tmp/lock/subsys/logs/sysRun.log" ###Log Dest
export MFILE=/tmp/info_$(date +%s).html 
export minimumsize=1400
# Your network info
export MYNETINFO="System Info for SDI Servers"
####MAIL####
export TOLIST="c9qa_sdi_ww_grp@oracle.com"
####
export FROM="haiyang.dong@oracle.com"
export SUB="Status of SDI Servers"

2. for same user and host/s run nopswd_con.sh
to add remote ssh keys to configure all slaves for monitoring daemon , passwordless ssh
#sh nopswd_con.sh slcn06vmf0021.us.oracle.com root
* Now run configure_systat.sh to create monitoring daemon "r_systat" and manage it by
used "rsys_dmn" service.
./configure_systat.sh

3.  finally run 
to launch daemon 
sudo service rsys_dmn start 
to Stop 
sudo service rsys_dmn stop

4. Check logs in 
/tmp/lock/subsys/logs/sysRun.log
5. Also it generates mailer under, mostly if there are no issues then it wont have any content , but u can use it to send mails 
/tmp/info.html
