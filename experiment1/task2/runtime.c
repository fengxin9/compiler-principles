// runtime.c
// 提供 SysY 运行时 I/O 函数
#include <stdio.h>

int getint(void) {
    int x;
    if (scanf("%d", &x) != 1) return 0;
    return x;
}

void putint(int x) {
    printf("%d", x);
}

void putch(int c) {
    putchar(c);
}