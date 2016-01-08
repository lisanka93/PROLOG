#include <iostream>
#include <sstream>
#include <string>
#include <stdio.h>
#include <string.h>

/*problem: the first loop in question 3 doesnt work, but all following ones work*/

using namespace std;

char encode(char one[], char two[]);
bool compare(char one[], char two[]);
bool compare2(char one[], char two[], int length);
int count(char soundexword[], string sentence);


int main()
{
  char soundex[5];

  cout << "====================== Question 1 ======================" << endl;

  encode("Washington", soundex);
  cout << "The soundex coding for 'Washington' is " << soundex << endl;

  encode("Lee", soundex);
  cout << "The soundex coding for 'Lee' is " << soundex << endl;

  encode("Jackson", soundex);
  cout << "The soundex coding for 'Jackson' is " << soundex << endl;


  cout << "====================== Question 2 ======================" << endl;

  cout << "The soundex codes S250 and S255 are ";
  if (!compare("S250", "S255"))
    cout << "not ";
  cout << "equal" << endl;

  cout << "The soundex codes W252 and W252 are ";
  if (!compare("W252", "W252"))
    cout << "not ";
  cout << "equal" << endl;


   cout << "====================== Question 3 ======================" << endl;

  cout << "There are ";
  cout << count("Jackson", "Jakes, Jaxin, Jacksin, Jones.");
  cout << " surnames in the sentence 'Jakes, Jaxin, Jacksin, Jones.'"
       << endl;
  cout << "  that have the same Soundex encoding as 'Jackson'" << endl << endl;

  cout << "There are ";
  cout << count("Leeson", "Linnings, Leasonne, Lesson, Lemon.") << " ";
  cout << "surnames in the sentence 'Linnings, Leasonne, Lesson and Lemon.'"
       << endl;
  cout << "  that have the same Soundex encoding as 'Leeson'" << endl;

    return 0;
}


char encode(char one[], char two[])
{
  int length;
  length = strlen(one);

  //initialise everything to zero
  two[0] = one[0];
  two[1] = '0';
  two[2] = '0';
  two[3] = '0';
  //sentinel value
  two[4] = '\n';
  int k = 1;


  for(int i = 1; i<length; i++)
  {
    if(one[i] == 'b' || one[i] == 'f' || one[i] == 'p' || one[i] == 'v')
    {
     two[k] = '1';
      if(two[k] != two[k-1])       //if same value as previous k will not be incremented
      {
       k++;
      }
    }
    if(one[i] == 'c' || one[i] == 'g' || one[i] == 'j' || one[i] == 'k' ||
       one[i] == 'q' || one[i] == 's' || one[i] == 'x' || one[i] == 'z')
    {
     two[k] = '2';
       if(two[k] != two[k-1])
      {
       k++;
      }
    }
    if(one[i] == 'd' || one[i] == 't')
    {
     two[k] = '3';
       if(two[k] != two[k-1])
      {
       k++;
      }
    }
    if(one[i] == 'l')
    {
     two[k] = '4';
       if(two[k] != two[k-1])
      {
       k++;
      }
    }
    if(one[i] == 'm' || one[i] == 'n')
    {
     two[k] = '5';
     if(two[k] != two[k-1])
      {
       k++;
      }
    }
     if(one[i] == 'r')
    {
     two[k] = '6';
     if(two[k] != two[k-1])
      {
       k++;
      }
    }
     if(k==4)
     break;
   }

}

bool compare(char one[], char two[])
{

  int length1 = strlen(one);
  int length2 = strlen(two);

  if (length1 != length2)
   return false;

  compare2(one, two, length1);             //need helper function with length to set base case  - well I do, maybe you dont
}

bool compare2(char one[], char two[], int length)
{
  char* ptr = one;
  char* ptr2 = two;

  if(length == 1 && *ptr == *ptr2)          //basecase
   return true;

  if(*ptr == *ptr2)
  {
   return compare2(++ptr, ++ptr2, length-1);     //comparing, decrementing length
  }
    return false;                          //otherwise false
}

int count(char soundexword[], string sentence)
{
  char soundex[5];
  char soundex2[5];

  encode(soundexword, soundex);
  istringstream iss(sentence);  //create a sentence stream to take out single words
  //iss >> ws;
  string word;

  char charword[20];
  int repcount = 0;

  while(!iss.eof())
  {
    iss >> word;
    strcpy(charword, word.c_str());     //convert the word in the string into a char
    encode(charword, soundex2);          //encode it

    if (compare(soundex, soundex2))         //compare it with the source word
    {
     repcount++;                    //count repetitions
    }
  }

  return repcount;
}
