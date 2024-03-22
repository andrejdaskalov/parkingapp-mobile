import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parkingapp/core/domain/parking.dart';
import 'package:parkingapp/core/repository/parking_repository.dart';

import 'package:parkingapp/core/dependency_injection/injectable_config.dart';
import 'bloc/main_page_bloc.dart';


class MainPage extends StatelessWidget {
  MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.map), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ],
        ),
        appBar: AppBar(
          title: const Text("ParkMe"),
          backgroundColor: Colors.transparent,
        ),
        body: BlocProvider(
          create: (context)  {
            var instance = getIt.get<MainPageBloc>();
            instance.add(GetPlaces());
            return instance;
          },
          child: BlocBuilder<MainPageBloc, MainPageState>(
            builder: (context, state) {
              if (state.status == Status.loading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state.status == Status.error) {
                return Center(child: Text(state.error));
              } else {
                return ListView.builder(
                  itemCount: state.places.length,
                  itemBuilder: (context, index) {
                    final place = state.places[index];
                    return ListTile(
                      title: Text(place.name),
                      subtitle: Text(place.address),
                    );
                  },
                );
              }
            },
          ),
        )

    );
  }
}