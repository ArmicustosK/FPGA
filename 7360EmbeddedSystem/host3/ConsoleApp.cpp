// main.cpp : This code is for a console application.
//
// This code writes a character to COM1 and then reads from COM1 a character which is displayed.
// It is to work with an HCS12 board on the other side of COM1 that echos back whatever the HCS12
// board receives from COM1.
//
// The COMport class is based on the code in http://members.ee.net/brey/Serial.pdf
//

#include "stdafx.h"

#include <atlstr.h>
#include <iostream>

// COMport class is defined
#include "COMport.h"

// needed when cin , cout are used
using namespace std;

// This is the entry point of a Visual C++ Console Application
int _tmain(int argc, _TCHAR* argv[])
{
	char data[100];
	COMport com;

	for (int i = 0; i<10; i++) 
	{
		char mychar;
		int mychar_num=0;
		cout << endl;
		
		cin.get(mychar); // this will read a character from keyboard, including a space character
						 //cin >> mychar; // this will read a character from keyboard, but skip a space character

						 //char b[100];
						 //cin.getline(b, 100); // this will read a whole line from keyboard
		mychar_num = mychar-'0';

		if (mychar_num < 10 && mychar_num > 0)
		//else
		{ 
			//com.write_and_read(mychar); // this is used to see if the other side (HCS12) is echoing back the char

			data[0] = mychar;
			//cout << mychar_num;
			com.write_n_data(data, 1);
			com.read_n_data(data, mychar_num);
			cout << data;
		}

	}

	//com.write_n_data(data, 3); // write three bytes to COM port
	//com.read_n_data(data, 3);  // read three bytes from COM port

}