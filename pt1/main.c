#include <stdio.h>

void display(int *numbers, int numbers_len);

int is_sorted(int *numbers, int numbers_len);

int main(){
    int N;
    int numbers[10];
    
    printf("N = ");
    scanf("%d", &N); 
    
    for (int i = 0; i < N; ++i){
        scanf("%d", numbers[i];
    }
    
    # display
    display(numbers, N);
    
    # is_sorted
    if (is_sorted(numbers, N)){
        printf("Array is sorted");
    } else {
        printf("Array is not sorted");
    }
    
    
    return 0;
}