/* CEG 7360 Lab 1 
    */

int ledPin = 13;
int buttonPin = 2;
int reading = 0;
int i=10;
void setup() 
{
  pinMode(ledPin,OUTPUT);
  pinMode(buttonPin, INPUT_PULLUP);
  Serial.begin(9600);
}

void loop() 
{
    reading = digitalRead(buttonPin);
    digitalWrite(ledPin, HIGH);
    if (reading == LOW)
    {
      digitalWrite(ledPin, LOW);
      i++;
    }
    
    if (i >=11)
      {
        Serial.println("HelloWorld");
        i=10;
      }
    
  
    
}
