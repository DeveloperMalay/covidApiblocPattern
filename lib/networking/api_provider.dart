import 'package:coviddata/model/covid_model.dart';
import 'package:dio/dio.dart';

class ApiProvider {
  final Dio dio = Dio();
  final String url = 'https://api.covid19api.com/summary';

  Future<CovidModel> getcovidData()async{
    try{
      Response response = await dio.get(url);
      return CovidModel.fromJson(response.data);
    }catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return CovidModel.withError("Data not found / Connection issue");
    }
  }
}
