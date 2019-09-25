import 'package:http/http.dart' as http;

void throwError(http.Response response) {
     if (response.statusCode != 200) {
        throw Exception('Error occured');
    }
}