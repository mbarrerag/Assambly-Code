/******************************************************************************

Welcome to GDB Online.
GDB online is an online compiler and debugger tool for C, C++, Python, Java, PHP, Ruby, Perl,
C#, OCaml, VB, Swift, Pascal, Fortran, Haskell, Objective-C, Assembly, HTML, CSS, JS, SQLite, Prolog.
Code, Compile, Run and Debug online from anywhere in world.

*******************************************************************************/
#pragma GCC optimize ("Og")
#include <iostream>

using namespace std;

volatile uint16_t aa[5]={3,4,5,6,7},b;
volatile uint16_t i=3;


int main()
{
    
    //b=aa[0]; 
    // asm volatile //Lo conoce en tiempo de compilacion
    // (
    //     "mov ax,[rip+aa] \n"
    //     "mov [rip+b],ax"
    //     :::"rax"
    // );
    
    //b=aa[2];  //Conoce en tiempo de compilacion 
    // asm volatile
    // (
    //     "mov ax,[rip+aa+4] \n"
    //     "mov [rip+b],ax"
    //     :::"rax"
    // );    
    
    //b=aa[i];  // Conoce en tiempo de ejecucion 
    // asm volatile
    // (
    //     "mov ax,[rip+i] \n"      //ax <-- (i)
    //     "movzx rax,ax \n"        //rax <-- (i) en 64 bits
    //     "lea rdx,[rip+aa] \n"    //rdx <-- dir de aa
    //     "mov ax,[rdx+rax*2] \n"  //ax <-- (aa+(i)*2) <--> ax <-- (a[i]) /rax tiene i
    //     "mov [rip+b],ax"
    //     :::"rax","rdx"
    // );      
    
    //Version simplificada
    
    
        // asm volatile
    // (
    //     "movx rax, word ptr[rip+i] \n"      //ax <-- (i) en 64 bits //Tome 16 bits y extiendalo a 64
    //     "lea rdx,[rip+aa] \n"    //rdx <-- dir de aa
    //     "mov ax,[rdx+rax*2] \n"  //ax <-- (aa+(i)*2) <--> ax <-- (a[i]) /rax tiene i
    //     "mov [rip+b],ax"
    //     :::"rax","rdx"
    // );      
    
    //b=aa[i-2]
    
    
    asm volatile
    (
        "mov ax, [rip+i] \n"
        "sub ax, 2 \n"
        "movzx r8, ax \n"
        "lea r9, [rip+aa] \n"
        "mov ax, [r9+r8*2] \n"
        "mov [rip+b],ax \n"
    );

    cout<<"b = "<<b<<endl;

    return 0;
}





