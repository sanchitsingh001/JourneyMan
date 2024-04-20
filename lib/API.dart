import 'package:http/http.dart' as http;

Future<String> Getdata(String url) async {
 http.Response response = await http.get(Uri.parse(url));
 String responseBody = response.body;
 print('Response Body: $responseBody');
 return responseBody;
}
