#! /bin/bash
#By Maxx

tempFile=`mktemp`
cat <<EOF >>$tempFile
   _____ __  __     _____ _
  / ____|  \/  |   / ____| |
 | (___ | \  / |  | |    | | ___  __ _ _ __   ___ _ __
  \___ \| |\/| |  | |    | |/ _ \/ _\` | '_ \ / _ \ '__|
  ____) | |  | |  | |____| |  __/ (_| | | | |  __/ |
 |_____/|_|  |_|   \_____|_|\___|\__,_|_| |_|\___|_|

EOF
result=`cat ${tempFile}`
IFS=$'\n'
for line in  $result
do
  echo "${line}"
  sleep 0.1
done                      

echo -e "\n"
clear_file(){
echo "[*]Start Clearing SystemdMiner Script Files, By DAS-SOCC CSIRT."
if [ -z "$(crontab -l | cut -d. -f2 | cut -d- -f3)" ] ;then
  echo "[*] No Crontab Jobs."
else
  for i in $(find / -name *$(crontab -l | cut -d. -f2 | cut -d- -f3)*);
  do rm $i;
  done
fi
echo "[+] Clearing Script Files Finished."
}



clear_cron(){
echo "[*]Start Clearing Crontab Jobs."
if [ -z "$(crontab -l | cut -d. -f2 | cut -d- -f3)" ] ;then
  echo "[*] No Crontab Jobs."
else
  for i in $(crontab -l | cut -d. -f2 | cut -d- -f3);
  do sed -i "/$i/d" /var/spool/cron/root;
  done
fi
echo "[+] Clearing Crontab Jobs Finished."
}


clear_proc_file(){
echo "[*]Start Clearing Virus Processes."
if [ -f "/tmp/.X11-unix/01" ] ;then
  kill -9 $(head -n 1 /tmp/.X11-unix/01);
else
  echo "[*] No tmp files.";
fi

if [ -f " /tmp/.X11-unix/11" ] ;then
  kill -9 $(head -n 1 /tmp/.X11-unix/11);
else
  echo "[*] No Tmp Files.";
fi
echo "[+] Clearing Virus Processes Finished."
}

lock_dir(){
echo "[*]Start Locking Tmp Direction."
if [ -f "/tmp/.X11-unix/01" ] ;then
  chattr +i /tmp/.X11-unix/01;
else
  echo "[*] No Tmp Files.";
fi
echo "[+] Locking Tmp Direction Finished."
}

clear_proc(){
echo "[*]Start Clearing Virus Processes."
if [ -f "/tmp/.X11-unix/01" ] ;then
  for i in `cat /sys/fs/cgroup/systemd$(cat /proc/$(head -n 1 /tmp/.X11-unix/11)/cgroup | grep "name=" | cut -d: -f3)/cgroup.procs`;
  do kill -9 $i;
  done
else
  echo "[*] No Tmp Files.";
fi
echo "[+] Clearing Virus Processes Finished."
}

clear_file
clear_cron
clear_proc_file
clear_proc
lock_dir
