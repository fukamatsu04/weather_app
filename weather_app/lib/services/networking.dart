import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkingHelper {
  final String url;

  NetworkingHelper(this.url);

  Future getData() async {
    var uriUrl = Uri.parse(url);
    http.Response response = await http.get(uriUrl);
    if (response.statusCode == 200) {
      String data = response.body;

      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}


//'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longtude&appid=$apiKey'