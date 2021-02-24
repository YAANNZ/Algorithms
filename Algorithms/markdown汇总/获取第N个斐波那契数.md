## Objctive-C
#### 时间复杂度高O(2^n)
- (int)fib:(int)input
{
    if (input <= 1) {
        return input;
    }
    
    return [self fib:input - 1] + [self fib:input - 2];
}

#### 时间复杂度低O(n)
- (int)fib2:(int)input
{
    if (input <= 1) {
        return input;
    }
    
    int first = 0;
    int second = 1;
    for (int i = 0; i < input - 1; i++) {
        int sum = first + second;
        first = second;
        second = sum;
    }
    
    return second;
}
