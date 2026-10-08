; example.ll
; SysY 示例程序的 LLVM IR 等价实现

; 声明 SysY 运行时库函数
declare i32 @getint()
declare void @putint(i32)
declare void @putch(i32)

; ============================================================
; 函数：is_prime
; ============================================================
define i32 @is_prime(i32 %n) {
entry:
    %n.addr = alloca i32, align 4
    store i32 %n, ptr %n.addr, align 4

    %0 = load i32, ptr %n.addr, align 4
    %cmp1 = icmp sle i32 %0, 1
    br i1 %cmp1, label %if.ret0, label %if.check2

if.ret0:
    ret i32 0

if.check2:
    %1 = load i32, ptr %n.addr, align 4
    %cmp2 = icmp eq i32 %1, 2
    br i1 %cmp2, label %if.ret1, label %if.continue

if.ret1:
    ret i32 1

if.continue:
    %i = alloca i32, align 4
    %flag = alloca i32, align 4
    store i32 2, ptr %i, align 4
    store i32 1, ptr %flag, align 4
    br label %while.cond

while.cond:
    %2 = load i32, ptr %i, align 4
    %3 = mul nsw i32 %2, %2
    %4 = load i32, ptr %n.addr, align 4
    %cmp3 = icmp sle i32 %3, %4
    br i1 %cmp3, label %while.body, label %while.end

while.body:
    %5 = load i32, ptr %n.addr, align 4
    %6 = load i32, ptr %i, align 4
    %rem = srem i32 %5, %6
    %cmp4 = icmp eq i32 %rem, 0
    br i1 %cmp4, label %if.setzero, label %if.next

if.setzero:
    store i32 0, ptr %flag, align 4
    br label %while.end

if.next:
    %7 = load i32, ptr %i, align 4
    %inc = add nsw i32 %7, 1
    store i32 %inc, ptr %i, align 4
    br label %while.cond

while.end:
    %8 = load i32, ptr %flag, align 4
    ret i32 %8
}

; ============================================================
; 函数：main
; ============================================================
define i32 @main() {
entry:
    %n.addr = alloca i32, align 4
    %primes = alloca [1000 x i32], align 4
    %count = alloca i32, align 4
    %i.addr = alloca i32, align 4
    %j.addr = alloca i32, align 4

    %n.val = call i32 @getint()
    store i32 %n.val, ptr %n.addr, align 4

    store i32 0, ptr %count, align 4
    store i32 1, ptr %i.addr, align 4
    br label %loop1.cond

loop1.cond:
    %i1 = load i32, ptr %i.addr, align 4
    %n1 = load i32, ptr %n.addr, align 4
    %cmp1 = icmp sle i32 %i1, %n1
    %cmp2 = icmp slt i32 %i1, 1000
    %and = and i1 %cmp1, %cmp2
    br i1 %and, label %loop1.body, label %loop1.end

loop1.body:
    %i2 = load i32, ptr %i.addr, align 4
    %call = call i32 @is_prime(i32 %i2)
    %cmp3 = icmp eq i32 %call, 1
    br i1 %cmp3, label %if.prime, label %if.next

if.prime:
    %cnt = load i32, ptr %count, align 4
    %ptr = getelementptr [1000 x i32], ptr %primes, i32 0, i32 %cnt
    %i3 = load i32, ptr %i.addr, align 4
    store i32 %i3, ptr %ptr, align 4

    %cnt2 = load i32, ptr %count, align 4
    %newcnt = add nsw i32 %cnt2, 1
    store i32 %newcnt, ptr %count, align 4
    br label %if.next

if.next:
    %i4 = load i32, ptr %i.addr, align 4
    %inext = add nsw i32 %i4, 1
    store i32 %inext, ptr %i.addr, align 4
    br label %loop1.cond

loop1.end:
    %finalcnt = load i32, ptr %count, align 4
    call void @putint(i32 %finalcnt)
    call void @putch(i32 10)

    store i32 0, ptr %j.addr, align 4
    br label %loop2.cond

loop2.cond:
    %j1 = load i32, ptr %j.addr, align 4
    %cnt3 = load i32, ptr %count, align 4
    %cmp4 = icmp slt i32 %j1, %cnt3
    br i1 %cmp4, label %loop2.body, label %loop2.end

loop2.body:
    %j2 = load i32, ptr %j.addr, align 4
    %ptr2 = getelementptr [1000 x i32], ptr %primes, i32 0, i32 %j2
    %val = load i32, ptr %ptr2, align 4
    call void @putint(i32 %val)
    call void @putch(i32 32)

    %j3 = load i32, ptr %j.addr, align 4
    %jnext = add nsw i32 %j3, 1
    store i32 %jnext, ptr %j.addr, align 4
    br label %loop2.cond

loop2.end:
    call void @putch(i32 10)
    ret i32 0
}