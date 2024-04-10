import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/dependency_injection/injectable_config.dart';
import '../presentation/bloc/main_page_bloc.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final double height;

  CustomAppBar({
    super.key,
    required this.height,
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(height);
}

class _CustomAppBarState extends State<CustomAppBar> {
  String searchValue = "";


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        var instance = getIt.get<MainPageBloc>();
        instance.add(GetPlaces());
        return instance;
      },
      child: BlocBuilder<MainPageBloc, MainPageState>(
        builder: (context, state) {
          return EasySearchBar(
              title: Text("ParkWise"),
              isFloating:true,
              elevation:20,
              openOverlayOnSearch:true,
              searchHintText:"Пребарај по име на паркинг",
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
              onSearch: (value) => setState(() => searchValue = value),
          suggestions: state.places
              .where((element) => element.name.contains(searchValue))
              .map((x) => x.name)
          .toList());
        },
      ),
    );
  }
}
