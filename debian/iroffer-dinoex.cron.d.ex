#
# Regular cron jobs for the iroffer-dinoex package
#
0 4	* * *	root	[ -x /usr/bin/iroffer-dinoex_maintenance ] && /usr/bin/iroffer-dinoex_maintenance
