library msg91_sms_otp;

import 'dart:math';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChangeOtpException implements Exception {
  String errMsg() => 'add {{otp}} in the string';
}

class SMSClient {
  String otp, url;
  Map headers, payload;
  int minOtpValue = 1000, maxOtpValue = 9999;

  SMSClient(String key, [String sender = "SOCKET"]) {
    headers = {'Content-type': 'application/json', 'authkey': key};

    if (sender.length == 6 && sender != "SOCKET")
      payload = {
        "route": "4",
        "country": "91",
        "sender": sender,
      };
    else {
      payload = {
        "route": "4",
        "country": "91",
        "sender": sender,
      };
    }

    otp = "Your otp is {{otp}}. Please do not share it with anybody";
    url = "https://api.msg91.com/api/v2/sendsms";
  }

  void changeOtp(String data, [int len = 4]) {
    if (len != 4) {
      minOtpValue = pow(10, len - 1);
      maxOtpValue = pow(10, len) - 1;
    }
    if (data.contains('{{otp}}'))
      otp = data;
    else
      throw new ChangeOtpException();
  }

  void sendMessgae(String data, List phno) {
    payload["sms"] = [
      {"message": data, "to": phno}
    ];  
    sendRequest();
  }

  int sendOtp(List phno) {
    int otpnum = minOtpValue + Random().nextInt(maxOtpValue - minOtpValue);
    String data = otp.replaceFirst("{{otp}}", otpnum.toString());
    payload["sms"] = [
      {"message": data, "to": phno}
    ];
    sendRequest();
    return otpnum;
  }

  void sendRequest() async {
    var response = await http.post(
      url,
      body: json.encode(payload),
      headers: headers,
    );
  }
}
