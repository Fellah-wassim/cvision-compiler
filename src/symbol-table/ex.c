#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <stdint.h>
#include <stdbool.h>

#define MAX_NAME 256
#define TABLE_SIZE 10

typedef struct element {
  char name[MAX_NAME];
  char code[20];
  char type[20];
  char value[20];
  struct element *next;
} element;

element * hash_table[TABLE_SIZE];

unsigned int hash(char *name){
  int length = strnlen(name, MAX_NAME);
  unsigned int hash_value = 0;
  for (int i=0; i < length; i++){
    hash_value += name[i];
    hash_value = (hash_value * name[i]) % TABLE_SIZE;
  }
  return hash_value;
}

bool init_hash_table(){
  for (int i=0; i < TABLE_SIZE; i++){
    hash_table[i] = NULL;
  }
}

void print_table(){
  printf("Table Start \n");
  for (int i=0; i < TABLE_SIZE; i++){
    if(hash_table[i] == NULL) {
      printf("\t%i\t---\n", i);
    }else{
      printf("\t%i\t", i);
      element *temp = hash_table[i];
      while (temp != NULL)
      {
        printf("%s <- ", temp->name);
        temp = temp->next;
      }
      printf("\n");
    }  
  }
  printf("Table End \n");
}

bool hash_table_insert(element *el){
  if(el == NULL) return false;
  int index = hash(el->name);
  el->next = hash_table[index];
  hash_table[index] = el;
  return true;
}

element *hash_table_lookup (char *name){
  int index = hash(name);
  element *temp = hash_table[index];
  while ( temp != NULL && strncmp(temp->name, name, MAX_NAME) != 0)
  {
    temp = temp->next;
  }
  return temp;
}

element *hash_table_delete(char *name){
  int index = hash(name);
  element *temp = hash_table[index];
  element *prev = NULL;
  while ( temp != NULL && strncmp(temp->name, name, MAX_NAME) != 0)
  {
    prev = temp;
    temp = temp->next;
  }
  if (temp == NULL) return NULL;
  if (prev == NULL){
    //head
    hash_table[index] = temp->next;
  }else{
    prev->next = temp->next;
  }
  return temp;
}

int main() {
  init_hash_table();

  element gg = {.name="gg", .code="gg", .type="gg", .value="gg"};
  element hh = {.name="hh", .code="hh", .type="hh", .value="hh"};
  element ll = {.name="ll", .code="ll", .type="ll", .value="ll"};
  element ss = {.name="ss", .code="ss", .type="ss", .value="ss"};
  element ggg = {.name="ggg", .code="ggg", .type="ggg", .value="ggg"};
  element hhh = {.name="hhh", .code="hhh", .type="hhh", .value="hhh"};
  element lll = {.name="lll", .code="lll", .type="lll", .value="lll"};
  element sss = {.name="sss", .code="sss", .type="sss", .value="sss"};

  hash_table_insert(&gg);
  hash_table_insert(&hh);
  hash_table_insert(&ll);
  hash_table_insert(&ss);
  hash_table_insert(&ggg);
  hash_table_insert(&hhh);
  hash_table_insert(&lll);
  hash_table_insert(&sss);

  print_table();


  return 0;
}