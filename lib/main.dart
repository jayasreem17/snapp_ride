import 'package:flutter/material.dart';
import 'package:flutter_project11/viewmodels/edit_details_viewmodel.dart';
import 'package:flutter_project11/viewmodels/hep_center_view_model.dart';
import 'package:flutter_project11/viewmodels/profile_details_viewmodel.dart';
import 'package:flutter_project11/viewmodels/refer_details_view_model.dart';
import 'package:flutter_project11/viewmodels/ride_details_view_model.dart';
import 'package:flutter_project11/viewmodels/saved_details_viewmodel.dart';
import 'package:flutter_project11/viewmodels/terms_view_model.dart';
import 'package:flutter_project11/views/yourprofile_view_screen.dart';
import 'package:provider/provider.dart';


import 'viewmodels/yourprofile_view_model.dart';
import 'viewmodels/privacy_view_model.dart';

import 'viewmodels/help_support_view_model.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProfileViewModel()),
        ChangeNotifierProvider(create: (_) => PrivacyPolicyViewModel()),
        ChangeNotifierProvider(create: (_) => RideHistoryViewModel()),
        ChangeNotifierProvider(create: (_) => HelpSupportViewModel()),
        ChangeNotifierProvider(create: (_) => EditDetailsViewModel()),
        ChangeNotifierProvider(create: (_) => SavedAddressesViewModel()),
        ChangeNotifierProvider(create: (_) => HelpCenterViewModel()),
        ChangeNotifierProvider(create: (_) => TermsAndConditionsViewModel()),
        ChangeNotifierProvider(create: (_) =>  ReferAndEarnViewModel()),
        ChangeNotifierProvider(create: (_) =>  ProfileDetailsViewModel()),



      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ProfileScreen(),
      ),
    ),
  );
}