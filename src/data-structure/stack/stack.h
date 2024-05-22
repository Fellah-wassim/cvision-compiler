#ifndef STACK_H
#define STACK_H

typedef struct Stack
{
  int *items;
  int top;
} Stack;

Stack *create_stack();

void push(Stack *stack, int data);

int pop(Stack *stack);

int is_empty(Stack *stack);

#endif // STACK_H