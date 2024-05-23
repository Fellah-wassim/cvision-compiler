#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <stdint.h>
#include <stdbool.h>
#define MAX_NAME 256
#define TABLE_SIZE 10

typedef struct element {
  int state;
  char name[MAX_NAME];
  char code[20];
  char type[20];
  float value;
  struct element *next;
} element;

element * symbol_table[TABLE_SIZE];

unsigned int hash(char *name){
  int length = strnlen(name, MAX_NAME);
  unsigned int hash_value = 0;
  for (int i=0; i < length; i++){
    hash_value += name[i];
    hash_value = (hash_value * name[i]) % TABLE_SIZE;
  }
  return hash_value;
}

bool init_symbol_table(){
  for (int i=0; i < TABLE_SIZE; i++){
    symbol_table[i] = NULL;
  }
}

void print_table() {
  printf("--------------------------------------------------------------------------------------------------------------------------------\n");
  printf("| %-45s | %-30s | %-30s | %-10s |\n", "Name", "Code", "Type", "Value");
  printf("--------------------------------------------------------------------------------------------------------------------------------\n");
  for (int i = 0; i < TABLE_SIZE; i++) {
    if (symbol_table[i] != NULL) {
      element *current = symbol_table[i];
      while (current != NULL) {
        printf("| %-45s | %-30s | %-30s | %-10.2f |\n", current->name, current->code, current->type, current->value);
        current = current->next;
      }
    }
  }
  printf("--------------------------------------------------------------------------------------------------------------------------------\n");
}

element *symbol_table_search (char *name){
  int index = hash(name);
  element *temp = symbol_table[index];
  while ( temp != NULL && strncmp(temp->name, name, MAX_NAME) != 0)
  {
    temp = temp->next;
  }
  return temp;
}

bool symbol_table_insert(char *name, char *code, char *type, float value){
  element *new_element = (element *)malloc(sizeof(element));
  if (new_element == NULL) {
    printf("Memory allocation failed!\n");
    exit(1);
  } 
  new_element->state = 1;
  strncpy(new_element->name, name, MAX_NAME);
  new_element->name[MAX_NAME - 1] = '\0'; 
  snprintf(new_element->code, 20, "%s", code);
  snprintf(new_element->type, 20, "%s", type);
  new_element->value = value;
  element *searchResult = symbol_table_search(new_element->name);
  int index = hash(new_element->name);
  if(searchResult == NULL){
    new_element->next = symbol_table[index];
    symbol_table[index] = new_element;
    return true;
  }else{
    // printf("'%s' Already exist in the symbol table \n", new_element->name);
    return false;
  }
}

bool symbol_table_insert_type(char *name, char *type) {
  element *el = symbol_table_search(name);
  if(el != NULL) {
    strcpy(el->type, type);
    return true;
  }
  return false;
}

bool symbol_table_insert_value(char *name, float value) {
  element *el = symbol_table_search(name);
  if(el != NULL) {
    el->value = value;
    return true;
  }
  return false;
}

bool isDoubleDeclared(char *name) {
  element *el = symbol_table_search(name);
  if(el != NULL) {
    if(strcmp(el->type, "") == 0) return false;
    return true;
  }
}