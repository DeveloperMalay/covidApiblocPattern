import 'package:coviddata/bloc/covid_bloc.dart';
import 'package:coviddata/bloc/covid_event.dart';
import 'package:coviddata/bloc/covid_state.dart';
import 'package:coviddata/model/covid_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CovidPage extends StatefulWidget {
  const CovidPage({Key? key}) : super(key: key);

  @override
  State<CovidPage> createState() => _CovidPageState();
}

class _CovidPageState extends State<CovidPage> {
  final CovidBloc _newBloc = CovidBloc();

  @override
  void initState() {
    _newBloc.add(GetCovidList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Covid Data"),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.all(8.0),
        child: BlocProvider(
          create: (_) => _newBloc,
          child: BlocListener<CovidBloc, CovidState>(
            listener: (context, state) {
              if (state is CovidError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message!),
                  ),
                );
              }
            },
            child: BlocBuilder<CovidBloc, CovidState>(
              builder: (context, state) {
                if (state is CovidInitial) {
                  return _buildLoading();
                } else if (state is CovidLoading) {
                  return _buildLoading();
                } else if (state is CovidLoaded) {
                  return _buildCard(context, state.covidModel);
                } else if (state is CovidError) {
                  return Container();
                } else {
                  return Container();
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, CovidModel model) {
    return ListView.builder(
        itemCount: model.countries!.length,
        itemBuilder: (context, index) {
          return Container(
            child: Card(
              child: Container(
                margin: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    Text("Country: ${model.countries![index].country}"),
                    Text(
                        "Total Confirmed: ${model.countries![index].totalConfirmed}"),
                    Text(
                        "Total Deaths: ${model.countries![index].totalDeaths}"),
                    Text(
                        "Total Recovered: ${model.countries![index].totalRecovered}"),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());
}
