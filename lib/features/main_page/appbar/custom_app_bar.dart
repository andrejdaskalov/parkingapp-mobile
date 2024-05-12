import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';
import '../../../core/dependency_injection/injectable_config.dart';
import '../presentation/bloc/main_page_bloc.dart';

class CustomAppBar extends StatefulWidget {
  CustomAppBar({
    super.key,
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  String searchValue = "";
  FloatingSearchBarController controller = FloatingSearchBarController();

  @override
  Widget build(BuildContext context) {
    context.read<MainPageBloc>().add(GetPlaces());
    debugPrint("Bloc in search: ${context.read<MainPageBloc>().hashCode}");
    return BlocBuilder<MainPageBloc, MainPageState>(
      builder: (context, state) {
        return FloatingSearchBar(
          builder: (BuildContext context, Animation<double> transition) {
            if (state.status == Status.error) {
              return Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.error_outline,
                      color: Theme.of(context).colorScheme.error,
                      size: 50,
                    ),
                    Text(
                      "Грешка при вчитување на паркинзи",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              );
            } else if (state.status == Status.loaded) {
              var filteredPlaces = state.places
                  .where((e) => e.name.contains(controller.query))
                  .toList();

              return ConstrainedBox(
                constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.7),
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: filteredPlaces
                          .map((e) => ListTile(
                        title: Text(e.name),
                        onTap: () {
                          context.read<MainPageBloc>().add(SelectPlace(e));
                          controller.close();
                        },
                      ))
                          .toList(),
                    ),
                  ),
                ),
              );
            } else
              return Container();
          },
          controller: controller,
          progress: state.status == Status.loading,
          transition: CircularFloatingSearchBarTransition(),
          backgroundColor: Theme.of(context).colorScheme.background,
          accentColor: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(10),
          hint: "Пребарај паркинг",
          onQueryChanged: (query) {
            setState(() {
              searchValue = query;
            });
          },
        );
      },
    );
  }
}
