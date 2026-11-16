#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>

const size_t SIZE = 40;
unsigned long long memo[SIZE] = {0};

unsigned long long fibo(int n) {
  if (n == 0 || n == 1) {
    return n;
  }
  if (memo[n]) {
    return memo[n];
  }
  return memo[n] = fibo(n - 1) + fibo(n - 2);
}

int main(void) {
  printf("%llu\n", fibo(SIZE));
  return EXIT_SUCCESS;
}
