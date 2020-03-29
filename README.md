# sms91-sms-otp
This a tiny library for sending sms and otp using [sms91](https://msg91.com/).

# Basic usage
You could simply send a message, OTP  and verify otp.

~~~~{.python}
from sms91.sendsms import SMSClient
cli = SMSClient()
#initializing app

# get this key from https://msg91.com
key = "31*****************P1" 
# sender can be of anything in the length of 6. in inbox it will be "AX-TESTIN".
sender = "TESTIN" 
# [optional] no.of char in otp. minimum 4 char  
otp_size = 6
cli.initialize(key,sender,otp_size)

#send sms
#phno list should have 10 digit indian numbers.
phno = ["98XXXXXXX0,'77XXXXXXXX5"]
message = "hi! this is a test message"
cli.sendMessgae(message,phno) 

#send otp
phno = ["98XXXXXXX0,'77XXXXXXXX5"]
cli.sendOtp(phno) 
~~~~
Yes, it is as simple as this.

