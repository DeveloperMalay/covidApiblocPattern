import 'package:coviddata/model/covid_model.dart';
import 'package:coviddata/networking/api_provider.dart';

class ApiRepository {
  final provider = ApiProvider();

  Future<CovidModel> repofetchCovidList() {
    return provider.getcovidData();
  }
}

class NetworkError extends Error {}
