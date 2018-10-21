#include<stdio.h>
    
int main(void){
	int a;
	int b;
	int c;
	printf("Enter two numbers to add\n");
	scanf("%d%d", &a, &b);
	c = a + b;
	printf("Sum of the numbers = %d\n", c);
	return 0;
}
