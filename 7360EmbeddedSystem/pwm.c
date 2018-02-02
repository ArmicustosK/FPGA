/*7360 EmbeddedSystem
* based on Altera FPGA chip: Atmel ATmega328P chip, Arduino UNO R3 board
*/
    const int PWMpin = 5;//set output pin
    const int buttonPin = 6;//set input pin, same frequency
    float frequency[10] = {62.5, 31.25, 20.83, 15.625, 12.5, 10.417, 8.929, 7.8125, 6.94, 6.25};
    //int frequency[10] = {63, 31, 21, 16, 13, 10, 9, 8, 7, 6};
    int n=0;
    int buttonState = 1;         // current state of the button
    int lastButtonState = 1;

void setup() {
    pinMode(buttonPin, INPUT);
    pinMode(PWMpin, OUTPUT);
    Serial.begin(9600);
}
/*.....End Inital....*/

void setPwmFrequency(int pin, int divisor) {
      byte mode;
      if(pin == 5 || pin == 6 || pin == 9 || pin == 10) {
            switch(divisor) {
                case 1: mode = 0x01; 
                        break;
                case 8: mode = 0x02;
                        break;
                case 64: mode = 0x03;
                        break;
                case 256: mode = 0x04;
                        break;
                case 1024: mode = 0x05;
                        break;
                default:
                        return;
            }
            if(pin == 5 || pin == 6) {
                TCCR0B = TCCR0B & 0b11111000 | mode;
            } else {
                TCCR1B = TCCR1B & 0b11111000 | mode;
            }
        } 
      else if(pin == 3 || pin == 11) {
            switch(divisor) {
                case 1: mode = 0x01;
                        break;
                case 8: mode = 0x02;
                        break;
                case 32: mode = 0x03;
                        break;
                case 64: mode = 0x04;
                        break;
                case 128: mode = 0x05;
                        break;
                case 256: mode = 0x06;
                        break;
                case 1024: mode = 0x07;
                        break;
                default:
                        return;
            }
            TCCR2B = TCCR2B & 0b11111000 | mode;
        }
    }

void loop() {
    
    analogWrite(PWMpin, 64);//outputs a 25% duty cycle
    buttonState = digitalRead(buttonPin);
    
    if (buttonState != lastButtonState) {
        if (buttonState == LOW){
            if (n!= 11){
                n = n + 1;
                setPwmFrequency(5,frequency[n]);//frequency
            }
            else n = 0;
        }
        delay(50);
    }

    lastButtonState = buttonState;
}
