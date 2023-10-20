/******************************************************************************

Welcome to GDB Online.
GDB online is an online compiler and debugger tool for C, C++, Python, Java, PHP, Ruby, Perl,
C#, OCaml, VB, Swift, Pascal, Fortran, Haskell, Objective-C, Assembly, HTML, CSS, JS, SQLite, Prolog.
Code, Compile, Run and Debug online from anywhere in world.

*******************************************************************************/
#include <iostream>

using namespace std;
volatile uint16_t a=45000,b=15000,c;

int main()
{
    cout<<"Hello World"<<endl;
    //c = a + b;
    asm volatile
    (
        "mov ax, [rip+a] \n" //[rip+variable] para traerlo de memoria
        "mov bx, [rip+b] \n"
        //"add ax,bx \n" //Suma en 16-bits sin ser algotítmico ax <-- a+b
        "add ax,[rip+b] \n" //Un operando puede estar en memoria
        "mov [rip+c],ax \n"
        :::"rax","rbx"
    );
    cout<<"c = " << c << endl;
    return 0;
}
