import 'package:core_ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_template/core/router/data/app_route_data.dart';
import 'package:flutter_app_template/core/router/data/weature/weature_route_data.dart';
import 'package:flutter_app_template/core/util/l10_extension.dart';
import 'package:timeago/timeago.dart' as timeago;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return AppBarFrame(
      shouldRemoveFocus: true,
      title: context.l10n.setting,
      init: () async {
        timeago.setDefaultLocale(Localizations.localeOf(context).languageCode);
      },
      body: Column(
        children: [
          Column(
            children: [
              InkWell(
                onTap: () {
                  const WeatureRouteData().go(context);
                },
                child: const Text(
                  'Weature',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
