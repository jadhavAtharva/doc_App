import 'package:http/http.dart' as http;

Future startPrescription (String url) async{
  http.Response response = await http.Client().put(
      url,
    headers: {
        'Content-type': 'application/json'
    },
  );
  return response.body;
}