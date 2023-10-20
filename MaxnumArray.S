/******************************************************************************

Welcome to GDB Online.
GDB online is an online compiler and debugger tool for C, C++, Python, Java, PHP, Ruby, Perl,
C#, OCaml, VB, Swift, Pascal, Fortran, Haskell, Objective-C, Assembly, HTML, CSS, JS, SQLite, Prolog.
Code, Compile, Run and Debug online from anywhere in world.

*******************************************************************************/
#include <iostream>

using namespace std;

volatile uint16_t arr1[5]={7,16,9,24,20},mx,i;

int main()
{
    cout<<"Hello World"<<endl;
    
    mx = arr1[0];
    for(i=1; i<5; i++)
    {
        //------------------ PROCESS --------------------------//
        //if(arr1[i]>mx)
        //{
          //  mx = arr1[i];
        //}
        L10:
        asm goto
        (
            "movzx rax, word ptr [rip+i] \n"
            "lea rcx, [rip+arr1] \n"
            "mov cx, [rcx+rax*2] \n"
            "mov dx, [rip+mx] \n"
            "cmp cx, dx \n"
            "jae %l[L20] \n"
            "jmp %l[L30] \n"
            :::"rax","rcx","dx":L20,L30
        );
        
        L20:
        //mx = arr1[i];
        asm volatile
        (
            "mov [rip+mx], cx \n"
        );
        
        L30:
        asm volatile
        (
            "nop"
        );
        //------------------------------------------------------//
    }
    
    cout<<"mx= "<<mx<<endl;
    return 0;
}

