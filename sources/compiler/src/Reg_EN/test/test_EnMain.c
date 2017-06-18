#include "./../Registers_encode.h"

int main(int argc, char const *argv[]) {

  printf("Test Start in %s\n",__FILE__);

  assert(register_encode("PC")      == 0);
  assert(register_encode("SP")      == 1);
  assert(register_encode("W")       == 2);
  assert(register_encode("SI")      == 3);
  assert(register_encode("FR_0")    == 4);
  assert(register_encode("FR_1")    == 5);
  assert(register_encode("FR_2")    == 6);
  assert(register_encode("FR_3")    == 7);
  assert(register_encode("FR_4")    == 8);
  assert(register_encode("FR_5")    == 9);
  assert(register_encode("FR_6")    == 10);
  assert(register_encode("FR_7")    == 11);
  assert(register_encode("FR_8")    == 12);
  assert(register_encode("FR_9")    == 13);
  assert(register_encode("FR_A")    == 14);
  assert(register_encode("FR_B")    == 15);
  assert(register_encode("FR_C")    == 16);
  assert(register_encode("FR_D")    == 17);
  assert(register_encode("FR_E")    == 18);
  assert(register_encode("FR_F")    == 19);
  assert(register_encode("STATUS")  == 20);
  assert(register_encode("PORTA")   == 21);
  assert(register_encode("PORTB")   == 22);
  assert(register_encode("UART_RX") == 23);
  assert(register_encode("UART_TX") == 24);
  assert(register_encode("SSR1")    == 25);

  printf("Test Exit\n");

  return 0;
}
