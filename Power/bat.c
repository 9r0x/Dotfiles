#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>
    
int main()
{
	system("kscreen-doctor output.eDP-2.mode.1");
	system("rfkill block bluetooth");
	setuid(0);
	system("nvidia-smi -i 0000:01:00.0 -pm 0");
	system("nvidia-smi drain -p 0000:01:00.0 -m 1");
	system("echo 15 | tee /sys/devices/system/cpu/cpu*/power/energy_perf_bias");
	system("for i in {1..11}; do echo 0 | sudo tee /sys/devices/system/cpu/cpu$i/online; done");
	return 0;
}
