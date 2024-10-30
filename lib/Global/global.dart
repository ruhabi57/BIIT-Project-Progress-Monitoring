//home
String baseUrl = 'http://192.168.100.17/BPPMAPI/api/';
//flatA
//String baseUrl = 'http://192.168.100.77/BPPMAPI/api/';
//phone
//String baseUrl = 'http://192.168.0.71/BPPMAPI/api/';
//flatS
//String baseUrl = 'http://192.168.0.71/BPPMAPI/api/';
String filesBaseUrl = 'http://192.168.0.71/BPPMAPI/';

dynamic userdata = {};

extension StringExtension on String {
  String capitalizeFirstLetter() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
