#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

void insertion(int *ary, size_t size) {
  for (size_t i = 1; i <= size; i++) {
    size_t j = i;
    int tmp = ary[i];
    while (j > 0 && ary[j - 1] > tmp) {
      ary[j] = ary[j - 1];
      j--;
    }
    ary[j] = tmp;
  }
}

int main(void) {
  const size_t SIZE = 100;
  const size_t RAND_LIMIT = 100;
  int array[SIZE];

  srand(time(NULL));
  for (size_t i = 0; i < SIZE; i++) {
    array[i] = rand() % RAND_LIMIT;
  }

  insertion(array, SIZE);

  for (size_t i = 1; i <= SIZE; i++) {
    printf("%2d ", array[i]);
    if (i % 10 == 0) {
      puts("");
    }
  }
  return EXIT_SUCCESS;
}
