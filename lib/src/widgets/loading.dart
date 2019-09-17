import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_demo/src/blocs/login_bloc.dart';
import 'package:flutter_bloc_demo/src/states/login_state.dart';

class LoadingWidget extends StatelessWidget {
  final bool _isLoading;
  LoadingWidget(this._isLoading);
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: _isLoading,
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery
            .of(context)
            .size
            .width,
        height: MediaQuery
            .of(context)
            .size
            .height,
        color: Colors.black54,
        child: CircularProgressIndicator(
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}