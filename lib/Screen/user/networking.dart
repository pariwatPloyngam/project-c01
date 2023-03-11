import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  String url = 'https://api.openrouteservice.org/v2/directions/';
  String apiKey = '5b3ce3597851110001cf624839c1739f39f94dab825525582a42f615';
  String mode = 'driving-car';
  double? startLat = 16.4053917;
  double? startLng = 102.807208;
  double? endLat = 16.4053917;
  double? endLng = 102.807208;

  NetworkHelper(
      {required this.startLng,
      required this.startLat,
      required this.endLng,
      required this.endLat});

  Future getData() async {
    Uri url2uri = Uri.parse(
        '$url$mode?api_key=$apiKey&start=$startLng,$startLat&end=$endLng,$endLat');

    http.Response response = await http.get(url2uri);
    print(
        '$url$mode?api_key=$apiKey&start=$startLng,$startLat&end=$endLng,$endLat');

    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}
