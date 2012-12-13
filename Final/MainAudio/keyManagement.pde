// Initializes an array for test purposes
// This is very ugly, but I couldnt find another way to convert an int to its corresponding char
// (it converts to its ASCII code)

final char tempo_key  = 't';
final char quit_key   = 'q';
final char pause_key  = 'p';
final char record_key = ' ';
final char delete_key = 'd';

void initCharArrays(){
    numArray = new char[NUMBER_OF_SAMPLES];
    if (NUMBER_OF_SAMPLES -1 >= 0) numArray[0] = '0';
    if (NUMBER_OF_SAMPLES -1 >= 1) numArray[1] = '1';
    if (NUMBER_OF_SAMPLES -1 >= 2) numArray[2] = '2';
    if (NUMBER_OF_SAMPLES -1 >= 3) numArray[3] = '3';
    if (NUMBER_OF_SAMPLES -1 >= 4) numArray[4] = '4';
    if (NUMBER_OF_SAMPLES -1 >= 5) numArray[5] = '5';
    if (NUMBER_OF_SAMPLES -1 >= 6) numArray[6] = '6';
    if (NUMBER_OF_SAMPLES -1 >= 7) numArray[7] = '7';
}

void keyPressed() 
{

  switch(key) {

    case tempo_key:
      toggleTempo();
      break;

    case quit_key:
      quit();
      break;

    case record_key:
      toggleRecord();
      break;

    case delete_key:
      delete();
      break;
    
  }
}


void keyReleased(){}
