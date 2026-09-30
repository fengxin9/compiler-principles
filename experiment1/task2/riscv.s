.option nopic
.text
.globl main


is_prime:
    li   t0, 1                # 比较分支不支持立即数，需先加载到寄存器
    ble  a0, t0, Ret0         # n <= 1，跳转Ret0
    li   t0, 2
    beq  a0, t0, Ret1         # n == 2，跳转Ret1
    li   t1, 2                # t1 = i = 2
    li   t2, 1                # t2 = flag = 1

Loop1:                        # while (i * i <= n)
    mul  t3, t1, t1           # t3 = i * i
    bgt  t3, a0, Done         # 若 i*i > n，跳出循环
    rem  t4, a0, t1           # t4 = n % i
    beqz t4, SetZero          # 若能整除，flag = 0并跳出
    addi t1, t1, 1            # i = i + 1
    j    Loop1

SetZero:
    li   t2, 0                # flag = 0

Done:
    mv   a0, t2               # 返回flag
    ret

Ret0:
    li   a0, 0               
    ret

Ret1:
    li   a0, 1            
    ret


main:
    addi sp, sp, -48          # 栈指针向下移动48字节
    sd   ra, 40(sp)           # 保存ra与s0~s3
    sd   s0, 32(sp)
    sd   s1, 24(sp)
    sd   s2, 16(sp)
    sd   s3, 8(sp)
    call getint               # 调用SysY运行时库的I/O函数
    mv   s0, a0               # s0 = n
    lla  s1, primes           # 加载基址，s1 = &primes[0]
    li   s2, 0                # s2 = count = 0
    li   s3, 1                # s3 = i = 1

Loop2:                        # while (i <= n && i < MAX_N)
    bgt  s3, s0, EndLoop2     # i > n退出
    li   t0, 1000             # MAX_N = 1000
    bge  s3, t0, EndLoop2     # i >= MAX_N退出

    mv   a0, s3
    call is_prime             # 调用is_prime(i)

    li   t0, 1
    bne  a0, t0, NextI
    slli t1, s2, 2            # t1 = count * 4
    add  t1, s1, t1           # t1 = &primes[count]
    sw   s3, 0(t1)            # primes[count] = i
    addi s2, s2, 1            # count = count + 1

NextI:
    addi s3, s3, 1            # i = i + 1
    j    Loop2

EndLoop2:                     # 输出素数个数
    mv   a0, s2
    call putint               # 输出整数，返回值在a0
    li   a0, 10               
    call putch                # 换行

    li   s3, 0                # 复用 s3 作为 j = 0

Loop3:                        # while (j < count)
    bge  s3, s2, EndLoop3
    slli t1, s3, 2            # t1 = j * 4
    add  t1, s1, t1           # t1 = &primes[j]
    lw   a0, 0(t1)            # a0 = primes[j]
    call putint               # 调用输出函数，返回值在a0
    li   a0, 32               # 空格
    call putch
    addi s3, s3, 1            # j = j + 1
    j    Loop3

EndLoop3:                     
    li   a0, 10               # 换行
    call putch
    ld   ra, 40(sp)           # 从栈中把之前保存的值加载回寄存器
    ld   s0, 32(sp)
    ld   s1, 24(sp)
    ld   s2, 16(sp)
    ld   s3, 8(sp)
    addi sp, sp, 48           # sp加回48释放栈帧
    ret                       # 返回

    .bss
    .align 2
primes:
    .zero 4000                # 分配4000字节空间给素数数组
