
import 'package:distech_technology/Features/Login/bloc/login_bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GlobalBloc extends StatelessWidget {
  final Widget child;
  const GlobalBloc({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (_)=>LoginBloc()),
    ], child: child);
  }
}