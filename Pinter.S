#pragma GCC optimize ("Og")
#include <iostream>

using namespace std;

volatile uint16_t *ptr,a=5,b;


int main()
{
    cout<<"Hello World"<<endl;
    
    ptr=&a; //& direccion de, * contenido de 
    // asm volatile
    // (
    //     "lea rax,[rip+a] \n"     //rax <-- dir de a 
    //     "mov [rip+ptr], rax \n"  //ptr <-- dir de a
    //     :::"rax"
    // );
    
    b=*ptr;
    // asm volatile
    // (
    //     "mov rax,[rip+ptr] \n"  //tomo la direccion de ptr //rax <--(ptr) <--> rax <-- dir de a
    //     "mov ax,[rax] \n "       //vaya a la direccion de rax y traigamelo a ax //ax <-- (a)
    //     "mov [rip+b],ax"
    //     :::"rax"
    // );
    
    cout<<"b = "<<b<<endl;

    return 0;
}



