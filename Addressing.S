/******************************************************************************

Welcome to GDB Online.
GDB online is an online compiler and debugger tool for C, C++, Python, Java, PHP, Ruby, Perl,
C#, OCaml, VB, Swift, Pascal, Fortran, Haskell, Objective-C, Assembly, HTML, CSS, JS, SQLite, Prolog.
Code, Compile, Run and Debug online from anywhere in world.

*******************************************************************************/
#pragma GCC optimize ("Og")
#include <iostream>

using namespace std;


volatile uint16_t a=5,b;


int main()
{
    cout<<"Hello World"<<endl;
    
    b=a;
    
    //Direccionamiento "Directo": no se usa registro que contenga direccion
    asm volatile
    (
        "mov ax,[rip+a] \n" //Ax copia tiene el cotenido de a
        "mov [rip+b],ax \n"
        :::"rax"
    );
    
    //Direccionamiento Indirecto: se usa registro que contiene direccion
    asm volatile
    (
        "lea rax,[rip+a] \n"//Calculamos la direccion y guardamos en rax necesitamos 64 bits //rax <-- dir de a //lea para direccionamiento Indirecto
        "mov ax, [rax] \n"      //ax <-- (a) //obligatorios []
        "mov [rip+b],ax"
        :::"rax"
    );
    
    cout<<"b = "<<b<<endl;

    return 0;
}




