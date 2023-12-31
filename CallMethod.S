#include <iostream>

using namespace std;

uint32_t foo(uint32_t x,uint32_t y,uint32_t z);

int main()
{
    cout<<"Hello World"<<endl;
    
    uint32_t a=7,b=6,z=8;   //prueba 1   ; c en [rbp-4], b en [rbp-8], a en [rbp-12] para assembly     
    //uint32_t a=7,b=2,z=8;   //prueba 2   ; c en [rbp-4], b en [rbp-8], a en [rbp-12] para assembly 
    
    //------------- PROCESO -------------------
    
    //z=foo(a,b,c);
       asm volatile
    (
      "mov esi,[rbp-4] \n" //(esi)<--z
      "mov edi,[rbp-8] \n" //(edi)<--y
      "mov edx, [rbp-12] \n" //(edx)<--x
      "call foo \n"
      "mov [rbp-4],eax" // cargamos z, lo que traemos de la funcion
    );
    
    //-----------------------------------------
    
    cout<<"z = "<<z<<endl;

    return 0;
}

//------------- PROCESO --------------------------------
/*
uint32_t foo(uint32_t x,uint32_t y,uint32_t z)
{
  uint32_t a=9,b=4; 
  if(y>b)
  {
      b=a+x;
  }
  else
  {
      b=b+z;
  }
    
  return b;
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
    "mov dword ptr [rbp-4],9 \n"  // [rbp-4]<--- a cargaremos 9
    "mov dword ptr [rbp-8],4 \n"  // [rbp-8] <--- b cargaremos 4
    
    //if(y>b)
    "mov ecx,[rbp-32] \n" //ecx <-- y de  main
    "cmp ecx,[rbp-8] \n" //Comparamos ecx (z) y b
    "jna L20 \n" //Si no es mayor, saltamos al else
    
    "L10:"
    //b=a+x;
    "mov ecx,[rbp-24] \n"   //(ecx)<--y de main
    "add ecx,[rbp-4] \n"    //Sumamos a + y de main
    "mov [rbp-8],ecx \n"    //(a)<--ecx (b+y)
    "jmp L30 \n" //Saltamos a L30 para salir del condicional
    
    "L20:"
    //b=b+z;
    "mov ecx,[rbp-32] \n"  //(ecx)<--x de main
    "add ecx,[rbp-8] \n"   //Sumamos a + y de main
    "mov [rbp-8],ecx \n"   //(a)<--ecx (a+y)
    
    "L30:"
    
    //return b; 
    "mov eax,[rbp-8] \n" //(eax)<--a

    //----------------------epilogue---------------------------------
    "add rsp,32 \n"         
    "pop rbp \n"
    "ret"
);





