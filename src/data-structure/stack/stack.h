#define MAX_SIZE 40

typedef struct Stack
{
  int *items;
  int top;
} Stack;

Stack *create_stack()
{
  Stack *stack = malloc(sizeof(Stack));

  stack->top = -1;
  stack->items = malloc(sizeof(int) * MAX_SIZE);

  return stack;
}

int is_empty(Stack *stack)
{
  return stack->top == -1;
}

void push(Stack *stack, int item)
{
  if (stack->top == MAX_SIZE - 1)
    return;

  stack->items[++stack->top] = item;
}

int pop(Stack *stack)
{
  if (is_empty(stack))
    return -1;

  return stack->items[stack->top--];
}