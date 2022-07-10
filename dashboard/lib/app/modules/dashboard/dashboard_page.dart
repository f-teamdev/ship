import 'package:admin/app/shared/constants.dart';
import 'package:admin/app/shared/widgets/custom_title.dart';
import 'package:admin/responsive.dart';
import 'package:flutter/material.dart';

import 'components/my_files.dart';
import 'components/recent_files.dart';
import 'components/storage_details.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomTitle(
      title: 'Dashboard',
      child: SingleChildScrollView(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      MyFiles(),
                      SizedBox(height: defaultPadding),
                      RecentFiles(),
                      if (Responsive.isMobile(context)) SizedBox(height: defaultPadding),
                      if (Responsive.isMobile(context)) StarageDetails(),
                    ],
                  ),
                ),
                if (!Responsive.isMobile(context)) SizedBox(width: defaultPadding),
                // On Mobile means if the screen is less than 850 we dont want to show it
                if (!Responsive.isMobile(context))
                  Expanded(
                    flex: 2,
                    child: StarageDetails(),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
