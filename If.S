//This code is in Asambling of Admega328
#pragma GCC optimize "-Og"
#include "ArduinoTrace.h"

volatile byte a=9,b=9;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);

//------------  process -----------------------
  // if (a>=b)
  // {
  //   a=a-b;
  // }
  // else
  // {
  //   a=a+b;
  // }
//---------------------------------------------
// if (a>=b)
// {
//   goto L10;
// }
// else
// {
//   goto L20;
// }
asm goto
(
  "lds r24, a \n" //cargar a en r24
  "lds r20, b \n"  //cargar b en r20
  "cp r24,r20 \n" //a-b
  "in r24,0x3F \n" //cargar SREG en r24
  "sbrs r24,0 \n" //sbrs pregunta por el bit0 de r24, osea C en SREG
  "rjmp %l[L10] \n"
  "rjmp %l[L20] \n" 
  :
  :
  :"r24", "r20"
  :L10,L20
);

L10:
a=a-b;
goto L30;

L20:
a=a+b;

L30:
DUMP(a);
}

void loop() {
  // put your main code here, to run repeatedly:

}
