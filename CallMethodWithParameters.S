#include <iostream>

using namespace std;

uint32_t foo(uint32_t x,uint32_t y,uint32_t z);

int main()
{
    cout<<"Hello World"<<endl;
    
    uint32_t a=7,b=6,z=8;   //prueba 1   ; c en [rbp-4], b en [rbp-8], a en [rbp-12] para assembly     
    //uint32_t a=7,b=6,z=9;   //prueba 2   ; c en [rbp-4], b en [rbp-8], a en [rbp-12] para assembly 
    
    //------------- PROCESO -------------------
    
   // a=foo(a,b,c);
     asm volatile
    (
      "mov esi,[rbp-4] \n" //(esi)<--z
      "mov edi,[rbp-8] \n" //(edi)<--y
      "mov edx, [rbp-12] \n" //(edx)<--x
      "call foo \n"
      "mov [rbp-12],eax" // cargamos a, lo que traemos de la funcion
    );
    
    
    //-----------------------------------------
    
    cout<<"a = "<<a<<endl;

    return 0;
}

//------------- PROCESO --------------------------------
/*
uint32_t foo(uint32_t x,uint32_t y,uint32_t z)
{
  uint32_t a=9,b=4; 
  if(z<a)
  {
      a=b+y;
  }
  else
  {
      a=a+x;
  }
    
  return a;
}
*/
//------------------------------------------------------

asm
(
    "foo:"
    //----------------------prologue---------------------------------
    "push rbp \n"
    "mov rbp,rsp \n"
    "sub rsp,32 \n"     
    "mov [rbp-32],esi \n"    // z en [rbp-32] valor de z de main
    "mov [rbp-28],edi \n"    // y en [rbp-28] valor de y de main
    "mov [rbp-24],edx \n"    // x en [rbp-24] valor de x de main
    //----------------------body-------------------------------------
    //uint32_t a=9,b=4;
    "mov dword ptr [rbp-4],4 \n"  // [rbp-4]<--- a cargaremos a
    "mov dword ptr [rbp-8],9 \n"  // [rbp-8] <--- b cargaremos b
    
    //if(z<a)
    "mov ecx,[rbp-32] \n" //ecx <-- z de  main
    "cmp ecx,[rbp-8] \n" //Comparamos ecx (z) y b
    "jnb L20 \n" //Si no es mayor, saltamos al else
    
    "L10:"
    //a=b+y;
    "mov ecx,[rbp-28] \n"   //(ecx)<--y de main
    "add ecx,[rbp-4] \n"    //Sumamos a + y de main
    "mov [rbp-8],ecx \n"    //(a)<--ecx (b+y)
    "jmp L30 \n" //Saltamos a L30 para salir del condicional
    
    "L20:"
    //a=a+x;
    "mov ecx,[rbp-24] \n"  //(ecx)<--x de main
    "add ecx,[rbp-8] \n"   //Sumamos a + y de main
    "mov [rbp-8],ecx \n"   //(a)<--ecx (a+y)
    
    "L30:"
    
    //return a; 
    "mov eax,[rbp-8] \n" //(eax)<--a

    //----------------------epilogue---------------------------------
    "add rsp,32 \n"         
    "pop rbp \n"
    "ret"
);






