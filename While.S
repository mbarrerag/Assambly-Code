    // while(n>=0)

/******************************************************************************

Welcome to GDB Online.
GDB online is an online compiler and debugger tool for C, C++, Python, Java, PHP, Ruby, Perl,
C#, OCaml, VB, Swift, Pascal, Fortran, Haskell, Objective-C, Assembly, HTML, CSS, JS, SQLite, Prolog.
Code, Compile, Run and Debug online from anywhere in world.

*******************************************************************************/
#pragma GCC optimize ("Og")
#include <iostream>

using namespace std;

volatile uint16_t n=5,sum,i;


int main()
{
    cout<<"Hello World"<<endl;
    /*
     while(n>=3) //12 = n>2
     {
       sum=sum+n;
         n--;
    }
    */
    L10:
    asm goto(
      "mov ax, [rip+n] \n"
      "cmp ax,3 \n"
      "jae %l[L20] \n"
      "jmp %l[L30] \n"
      :::"rax":L20,L30
    );
    
    L20:
    //sum=sum+n;
    asm volatile
    (
        "mov ax, [rip+n] \n"
        "add [rip+sum], ax \n"
    
    );
    //n--;
    asm goto(
    "mov ax, [rip+n] \n"
    "dec ax \n"
    "mov [rip+n], ax\n"
    "jmp %l[L10] \n"
    :::"rax":L10
    );  
    
 
    
    
    L30:
    cout<<"sum = "<<sum<<endl;

    return 0;
}


