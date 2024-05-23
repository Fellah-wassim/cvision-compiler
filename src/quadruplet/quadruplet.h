#include<string.h>
#include<stdio.h>
#include<stdlib.h>

#define MAX_QUADRUPLETS 100
int Qc = 0;

typedef struct {
  char operation[25]; 
  char operator1[25];   
  char operator2[25];   
  char stocker[25];  
} quadType;

quadType quadTable[MAX_QUADRUPLETS];

void quad(char operation[], char operator1[], char operator2[], char stocker[]) {
	strcpy(quadTable[Qc].operation, operation);
	strcpy(quadTable[Qc].operator1, operator1);
	strcpy(quadTable[Qc].operator2, operator2);
	strcpy(quadTable[Qc].stocker, stocker);
  Qc++;
}

void quad_updated(int qc, int colone, char value []) {
  switch (colone)
  {
    case 1 :
      strcpy(quadTable[qc].operation, value);
      break;
    case 2 :
      strcpy(quadTable[qc].operator1, value);
      break;
    case 3 :
      strcpy(quadTable[qc].operator2, value);
      break;
    case 4 :
      strcpy(quadTable[qc].stocker, value);
      break;
  }
}

void display_quad() {
  int counter;
  for(counter=0; counter<Qc; counter++)
  {
    printf("\n %d - ( %s  ,  %s  ,  %s  ,  %s )\n", counter, quadTable[counter].operation, quadTable[counter].operator1, quadTable[counter].operator2, quadTable[counter].stocker); 
    printf("\n--------------------------------------------------------\n");
  }
}

// OPTIMIZATION

void propagate_copy() {
  int i;
  for (i = 0; i < Qc; i++) {
    if (strcmp(quadTable[i].operation, ":=") == 0) {
      char operator1[25];
      strcpy(operator1, quadTable[i].operator1);

      for (int j = i + 1; j < Qc; j++) {
        if (strcmp(quadTable[j].operator1, operator1) == 0) strcpy(quadTable[j].operator1, quadTable[i].stocker);
        if (strcmp(quadTable[j].operator2, operator1) == 0) strcpy(quadTable[j].operator1, quadTable[i].stocker);
      }
    }
  }
}

void simplify_algebra() {
  int i;
  for (i = 0; i < Qc; i++) {
    if (strcmp(quadTable[i].operation, ":=") == 0) {
      if (strcmp(quadTable[i].operation, "*") == 0 && strcmp(quadTable[i].operator2, "1") == 0) {
        strcpy(quadTable[i].operation, ":=");
        strcpy(quadTable[i].operator2, " ");
      }
      else if (strcmp(quadTable[i].operation, "*") == 0 && strcmp(quadTable[i].operator2, "0") == 0) {
        strcpy(quadTable[i].operation, ":=");
        strcpy(quadTable[i].operator1, "0");
        strcpy(quadTable[i].operator2, " ");
      }
      else if (strcmp(quadTable[i].operation, "+") == 0) {
        if (strcmp(quadTable[i].operator2, "0") == 0) {
          strcpy(quadTable[i].operation, ":=");
          strcpy(quadTable[i].operator2, " ");
        }
      }
      else if (strcmp(quadTable[i].operation, "-") == 0) {
        if (strcmp(quadTable[i].operator2, "0") == 0) {
          strcpy(quadTable[i].operation, ":=");
          strcpy(quadTable[i].operator2, " ");
        }
      }
      else if (strcmp(quadTable[i].operation, "/") == 0) {
        if (strcmp(quadTable[i].operator2, "1") == 0) {
          strcpy(quadTable[i].operation, ":=");
          strcpy(quadTable[i].operator2, " ");
        }
      }
      else if (strcmp(quadTable[i].operation, "+") == 0 || strcmp(quadTable[i].operation, "-") == 0){
        if (strcmp(quadTable[i].operator1, quadTable[i].operator2) == 0){
          if (strcmp(quadTable[i].operation, "+") == 0){
            strcpy(quadTable[i].operation, "*");
            strcpy(quadTable[i].operator2, "2");
          } else if (strcmp(quadTable[i].operation, "-") == 0){
            strcpy(quadTable[i].operation, ":=");
            strcpy(quadTable[i].operator1, "0");
            strcpy(quadTable[i].operator2, " ");
          }
        }
      }
    }
  }
}

void eliminate_dead_code() {
  int i;
  for (i = 0; i < Qc; i++) {
    if (strcmp(quadTable[i].operation, ":=") == 0) {
      bool unused = true;
      for (int j = i + 1; j < Qc; j++) {
        if (strcmp(quadTable[j].operator1, quadTable[i].stocker) == 0 || strcmp(quadTable[j].operator2, quadTable[i].stocker) == 0) {
          unused = false;
          break;
        }
      }
      if (unused) {
        strcpy(quadTable[i].operation, "Dead Code");
        strcpy(quadTable[i].operator1, "Dead Code");
        strcpy(quadTable[i].operator2, "Dead Code");
        strcpy(quadTable[i].stocker, "Dead Code");
      }
    }
  }
}

void eliminate_common_subexpressions() {
  for (int i = 0; i < Qc; i++) {
    for (int j = i + 1; j < Qc; j++) {
      if (strcmp(quadTable[i].operation, quadTable[j].operation) == 0 &&
        strcmp(quadTable[i].operator1, quadTable[j].operator1) == 0 &&
        strcmp(quadTable[i].operator2, quadTable[j].operator2) == 0) {
        
        strcpy(quadTable[j].operator1, quadTable[i].stocker);
        strcpy(quadTable[j].operation, ":=");
        strcpy(quadTable[j].operator2, " ");
      }
    }
  }
}

void optimize_quad(){
  propagate_copy();
  eliminate_dead_code();
  eliminate_common_subexpressions();
  simplify_algebra();
}

void save_quad_to_file(const char* filename) {
  int i;
  FILE* fp = fopen(filename, "w");
  if (fp == NULL) {
    perror("Error opening file");
    return;
  }
  fprintf(fp, "\n | QUADRUPLETS\n");
  fprintf(fp, " |\t--------------------------------------------------------\n |");
  for (i = 0; i < Qc; i++){
    fprintf(fp, "\n |\t %d - ( %s  ,  %s  ,  %s  ,  %s )", i, quadTable[i].operation, quadTable[i].operator1, quadTable[i].operator2, quadTable[i].stocker); 
    fprintf(fp, "\n |\t--------------------------------------------------------\n |");
  }
  fprintf(fp, "-\n");
  fclose(fp);
}


// Generate Code

void generate_code() {
  int i;
  for (i = 0; i < Qc; i++) {
    printf("\n%d:\t", i);
    if (strcmp(quadTable[i].operation, "+") == 0) {
      printf("\n |\t Addition\n");
      printf(" |\t MOV AX, %s\n", quadTable[i].operator1);
      printf(" |\t ADD AX, %s\n", quadTable[i].operator2);
      printf(" |\t MOV %s, AX\n", quadTable[i].stocker);
    } else if (strcmp(quadTable[i].operation, "-") == 0) {
      printf("\n |\t Subtraction\n");
      printf(" |\t MOV AX, %s\n", quadTable[i].operator1);
      printf(" |\t SUB AX, %s\n", quadTable[i].operator2);
      printf(" |\t MOV %s, AX\n", quadTable[i].stocker);
    } else if (strcmp(quadTable[i].operation, "*") == 0) {
      printf("\n |\t Multiplication\n");
      printf(" |\t MOV AX, %s\n", quadTable[i].operator1);
      printf(" |\t MUL %s\n", quadTable[i].operator2);
      printf(" |\t MOV %s, AX\n", quadTable[i].stocker);
    } else if (strcmp(quadTable[i].operation, "/") == 0) {
      printf("\n |\t Division\n");
      printf(" |\t MOV AX, %s\n", quadTable[i].operator1);
      printf(" |\t MOV BX, %s\n", quadTable[i].operator2);
      printf(" |\t DIV BX\n");
      printf(" |\t MOV %s, AX\n", quadTable[i].stocker);
    } else if (strcmp(quadTable[i].operation, "%") == 0) {
      printf("\n |\t Modulo\n");
      printf(" |\t MOV AX, %s\n", quadTable[i].operator1);
      printf(" |\t MOV BX, %s\n", quadTable[i].operator2);
      printf(" |\t DIV BX\n");
      printf(" |\t MOV %s, DX\n", quadTable[i].stocker);
    } else if (strcmp(quadTable[i].operation, ":=") == 0) {
      printf("\n |\t Assignment\n");
      printf(" |\t MOV AX, %s\n", quadTable[i].operator1);
      printf(" |\t MOV %s, AX\n", quadTable[i].stocker);
    } else if (strcmp(quadTable[i].operation, "goto") == 0) {
      printf("\n |\t Unconditional jump\n");
      printf(" |\t JMP %s\n", quadTable[i].stocker);
    } else if (strcmp(quadTable[i].operation, "if") == 0) {
      printf("\n |\t Conditional jump\n");
      printf(" |\t MOV AX, %s\n", quadTable[i].operator1);
      printf(" |\t CMP AX, %s\n", quadTable[i].operator2);
      printf(" |\t JNE %s\n", quadTable[i].stocker);
    } else if (strcmp(quadTable[i].operation, "&") == 0) {
      printf("\n |\t Bitwise AND\n");
      printf(" |\t MOV AX, %s\n", quadTable[i].operator1);
      printf(" |\t AND AX, %s\n", quadTable[i].operator2);
      printf(" |\t MOV %s, AX\n", quadTable[i].stocker);
    } else if (strcmp(quadTable[i].operation, "|") == 0) {
      printf("\n |\t Bitwise OR\n");
      printf(" |\t MOV AX, %s\n", quadTable[i].operator1);
      printf(" |\t OR AX, %s\n", quadTable[i].operator2);
      printf(" |\t MOV %s, AX\n", quadTable[i].stocker);
    } else if (strcmp(quadTable[i].operation, "&&") == 0) {
      printf("\n |\t Logical AND\n");
      printf(" |\t MOV AX, %s\n", quadTable[i].operator1);
      printf(" |\t AND AX, %s\n", quadTable[i].operator2);
      printf(" |\t MOV %s, AX\n", quadTable[i].stocker);
    } else if (strcmp(quadTable[i].operation, "||") == 0) {
      printf("\n |\t Logical OR\n");
      printf(" |\t MOV AX, %s\n", quadTable[i].operator1);
      printf(" |\t OR AX, %s\n", quadTable[i].operator2);
      printf(" |\t MOV %s, AX\n", quadTable[i].stocker);
    }
  }
}