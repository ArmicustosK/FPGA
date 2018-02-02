int lastbuttonstate=1;
int currentbuttonstate=1;
int digitalPin=12;
int pin = 7;
//unsigned long duration;
unsigned long duration;
float d;
 unsigned long duty1,duty2;
// Duty Cycle in terms of a percentage.
unsigned long plus;
// Value read from A1, in case plus mode is activated
float xxx;
// Float numbers to calculate duty for PWM 1 and PWM 2
float yyy;
unsigned long pwm1;
// Value read from A0 and A2 to give PWM duty cycle output in terms // of 0-5V
unsigned long pwm2;
float t[]={1000,500,333,250,200,166.666,142.85714286714,125,111.11111,100};
int i=0;

void setup(){
 pinMode(pin, INPUT);
pinMode (digitalPin,INPUT_PULLUP);
pinMode(9, OUTPUT);
pinMode(10, OUTPUT);
TCCR1A = _BV(COM1A1) | _BV(COM1B1) ; // phase and frequency correct mode. NON-inverted mode
// TCCR1A = _BV(COM1A1) | _BV(COM1B1) | _BV(COM1A0) | _BV(COM1B0) ;
//phase/frequency correct mode. SELECT THIS FOR INVERTED OUTPUTS.
TCCR1B = _BV(WGM13) | _BV(CS11);
// Select mode 8 and select divide by 8 on main clock.
Serial.begin(9600);
}
void loop(){
// Program that lets different values on A3 choose different values of frequency, e.g. 100,200,400,500,1k,2k,3k,4k,10k,
//etc in relation with a free input.
char buffer[80];



ICR1=t[i];

//ICR1 = 1000; // for ICR1 = 1000, frequency = 1kHz.
pwm1 = 250; // read duty from A2 for PWM 2
//pwm2 = analogRead(A0); // read duty from A0 for PWM 1
//xxx = float(pwm2);
// Turn read values from the POTs to float for mathematical
// adjustment.
yyy = float(pwm1);
//xxx = xxx * ICR1;
// Multiply with ICR1 and divide by 1023 to give required percentage
yyy = yyy * ICR1;
//xxx = xxx / 1023;
yyy = yyy / 1023;
//Assign values to OCR Registers, which output the PWM duty cycle.
//OCR1B = int(xxx);
OCR1A = int(yyy);


currentbuttonstate= digitalRead (digitalPin);
    
   if (currentbuttonstate== LOW && lastbuttonstate==HIGH)
   {
   duration = pulseIn(pin, HIGH)+pulseIn(pin, LOW);
 
 Serial.println(1/(float) duration*1000); 
   }
    
    
    if (currentbuttonstate== HIGH && lastbuttonstate==LOW)
    { 
    if (i<9){
    i=i+1;
    }
    else
      i=0;
       } 
    lastbuttonstate= currentbuttonstate;
delay(20);


 
}
