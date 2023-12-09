#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>

int main()
{
	if (setenv("PATH", "/usr/bin", 1) != 0)
	{
		perror("Failed to set PATH");
		exit(EXIT_FAILURE);
	}

	system("kscreen-doctor output.eDP-2.mode.0");
	system("rfkill unblock bluetooth");
	setuid(0);
	system("nvidia-smi drain -p 0000:01:00.0 -m 0");
	system("nvidia-smi -i 0000:01:00.0 -pm 1");
	system("echo 0 | tee /sys/devices/system/cpu/cpu*/power/energy_perf_bias");
	system("for i in {1..11}; do echo 1 | sudo tee /sys/devices/system/cpu/cpu$i/online; done");
	system("echo 0 | tee /sys/devices/system/cpu/intel_pstate/no_turbo");
	return 0;
}
