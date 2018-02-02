/* CEG 7360 Lab 1 
   Yang Qu */

int ledPin = 13;
int buttonPin = 2;
int reading = 0;

void setup() 
{
  pinMode(ledPin,OUTPUT);
  pinMode(buttonPin, INPUT_PULLUP);
  Serial.begin(9600);
}

void loop() 
{
    reading = digitalRead(buttonPin);
    if (reading == HIGH)
    {
      digitalWrite(ledPin, HIGH);
    }
    else if (reading == LOW)
    {
      digitalWrite(ledPin, LOW);
      Serial.println("HelloWorld");
    }
    


    
    
}
