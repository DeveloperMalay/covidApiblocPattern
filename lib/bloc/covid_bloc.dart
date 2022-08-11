import 'package:coviddata/bloc/covid_event.dart';
import 'package:coviddata/bloc/covid_state.dart';
import 'package:coviddata/repository/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CovidBloc extends Bloc<CovidEvent, CovidState> {
  CovidBloc() : super(CovidInitial()) {
    final ApiRepository apiRepository = ApiRepository();

    on<GetCovidList>((event, emit) async {
      try {
        emit(CovidLoading());
        final mList = await apiRepository.repofetchCovidList();
        emit(CovidLoaded(mList));
        if (mList.error != null) {
          emit(CovidError(mList.error));
        }
      } on NetworkError {
        emit(const CovidError("Failed to fetch data. is your device online?"));
      }
    });
  }
}
