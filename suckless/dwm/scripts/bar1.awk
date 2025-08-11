BEGIN {
	cmd = "date '+%M %H %d %m %W'"
	cmd | getline time
	close(cmd)
	split(time, t, " ")
	t[5]++
	FS = " "



	while(1) {
		# CPU usage
		getline < "/proc/loadavg"
		CPU = $1
		close("/proc/loadavg")

		# Memory usage
		getline < "/proc/meminfo" # line 1 is MemoryTotal
		MemT = $2
		getline < "/proc/meminfo" # skip past line 2
		getline < "/proc/meminfo" # line 3 is MemoryAvailable
		Mem = (MemT - $2) / 1000000
		close("/proc/meminfo")

		cmd = sprintf("dwm -s '^c#11111B^^b#F28FAD^  ^c#F28FAD^^b#11111B^ %.2f ^c#11111B^^b#FAB387^  ^c#FAB387^^b#11111B^ %.1fG ^c#11111B^^b#ABE9B3^ 󱑆 ^c#ABE9B3^^b#11111B^ %s:%s ^c#11111B^^b#96CDFB^ 󰸗 ^c#96CDFB^^b#11111B^ %s/%s ^c#11111B^^b#CBA6F7^ W ^c#CBA6F7^^b#11111B^ %s '", CPU, Mem, t[2], t[1], t[3], t[4], t[5])
		system(cmd)
		system("sleep 10")
	}
}
