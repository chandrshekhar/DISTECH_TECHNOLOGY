import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CustomFooterWidget extends StatelessWidget {
  const CustomFooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomFooter(builder: ((context, mode) {
      Widget body;
      if (mode == LoadStatus.loading) {
        body = const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Data loading"),
            SizedBox(
              width: 10,
            ),
            CircularProgressIndicator.adaptive(),
          ],
        );
      } else if (mode == LoadStatus.failed) {
        body = const Text("Load Failed! Click retry!");
      } else if (mode == LoadStatus.canLoading) {
        body = const Text("Release to load more");
      } else {
        body = const Text("No more data");
      }
      return SizedBox(
        height: 40.0,
        child: Center(
          child: body,
        ),
      );
    }));
  }
}
