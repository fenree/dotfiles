#!/bin/dash



awk '
/Mouse$/ {
	i = NR-1
	printf("/dev/event%d", i)
	system("ln -snf /dev/input/event" i " /dev/input/mouse")
} 
/Splinky$/ {
	i = NR-1
	printf("/dev/event%d", i)
	system("ln -snf /dev/input/event" i " /dev/input/kbd")
}' /sys/class/input/i*/name
