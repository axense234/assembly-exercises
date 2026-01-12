#include <stdio.h>

int num_product(int *numbers, int LEN);

int main(){
    int numbers[] = {2, 2, 2, 2, 2};
    
    int len_numbers = sizeof(numbers) / sizeof(int);
    int product = num_product(numbers, len_numbers);
    
    printf("product: %d", product);
    
    return 0;
}