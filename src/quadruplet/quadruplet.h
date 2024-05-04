#include<string.h>
#include<stdio.h>
#include<stdlib.h>

#define MAX_QUADRUPLETS 100
int Qc = 0;

//struct of the quad
typedef struct
{
  char operation[20]; 
  char operator1[20];   
  char operator2[20];   
  char stocker[20];  
} quadType; 

quadType quadTable[MAX_QUADRUPLETS];

//function to insert quad
void quad(char operation[], char operator1[], char operator2[], char stocker[])
{
	strcpy(quadTable[Qc].operation, operation);
	strcpy(quadTable[Qc].operator1, operator1);
	strcpy(quadTable[Qc].operator2, operator2);
	strcpy(quadTable[Qc].stocker, stocker);
  Qc++;
}

//function update the quad value
void quad_updated(int numberQuad, int colone, char value [])
{
  switch (colone)
  {
  case 1 :
    strcpy(quadTable[numberQuad].operation, value);
    break;
  case 2 :
    strcpy(quadTable[numberQuad].operator1, value);
    break;
  case 3 :
    strcpy(quadTable[numberQuad].operator2, value);
    break;
  case 4 :
    strcpy(quadTable[numberQuad].stocker, value);
    break;
  }
}

//function to display quad table
void display_quad()
{
  printf("\n******************************* Quadruplets *******************************\n");
  int counter;
  for(counter=0; counter<Qc; counter++)
  {
    printf("\n %d - ( %s  ,  %s  ,  %s  ,  %s )\n",counter, quadTable[counter].operation, quadTable[counter].operator1, quadTable[counter].operator2, quadTable[counter].stocker); 
    printf("\n--------------------------------------------------------\n");
  }
}