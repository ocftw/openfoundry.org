#include <syscall.h>

#define  __NR_move_to_external 331
#define  SYS_move_to_external __NR_move_to_external

int main(int argc, char *argv[])
{
	int i, pid, period, execution;
	long long x;
	
	period=atoi(argv[1]);
	execution=atoi(argv[2]);

	pid=getpid();
	syscall(SYS_move_to_external, pid, period, execution);
	execvp(argv[3], &argv[3]);
	perror("execvp");

	return 0;
}

