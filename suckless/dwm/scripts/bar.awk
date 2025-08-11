# file input order is time ; date ; loadavg ; meminfo
BEGIN {
	cmd = "date '+%M %H %d %m %W'"
	cmd | getline time
	close(cmd)
	split(time, t, " ")
	t[5]++
	FS = ":"
	black="#11111B"
	green="#ABE9B3"
	white="#D9E0EE"
    grey="#282737"
    blue="#96CDFB"
    orange="#fab387"
    yellow="#F9E2AF"
    red="#F28FAD"
    darkblue="#83BAE8"
    mauve="#cba6f7"
    lavender="#b4befe"
    base="#1e1e2e"
}

# CPU Load (/proc/loadavg)
NR == 1 {
	CPU = $1 # loadavg over 1 min
}

# Memory Usage
NR > 1 && /MemT/ {
	MemT = $2
} /MemA/ {
	MemU = MemT - $2;
	len = length(MemU);
	if(len > 6) { # 6 digits from KB to GB igonring check for TB mem consumption 
		i = len - 6;
		Mem = substr(MemU, 1, i) "." substr(MemU,len - 5, i) "G";
	}
	else {
		Mem = substr(MemU, 1, 3) "M";
	}
}  

END {
	printf("^c%s^^b%s^  ^c%s^^b%s^ %.2f ^c%s^^b%s^  ^c%s^^b%s^ %s ^c%s^^b%s^ 󱑆 ^c%s^^b%s^ %s:%s ^c%s^^b%s^ 󰸗 ^c%s^^b%s^ %s/%s^c%s^ ^b%s^ W ^c%s^^b%s^ %s ",black, red, red, black,CPU, black, orange, orange, black, Mem, black, green, green, black, t[2], t[1], black, blue, blue, black, t[3], t[4], black, mauve, mauve, black, t[5])
}
