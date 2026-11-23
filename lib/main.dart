import 'package:flutter/material.dart';
import 'package:flutter_project11/features/yourprofiledetails/editdetails/viewmodel/edit_details_viewmodel.dart';
import 'package:flutter_project11/features/yourprofiledetails/helpcenter/viewmodel/help_center_view_model.dart';
import 'package:flutter_project11/features/yourprofiledetails/profiledetails/viewmodel/profile_details_viewmodel.dart';
import 'package:flutter_project11/features/yourprofiledetails/referandearn/viewmodel/refer_details_view_model.dart';
import 'package:flutter_project11/features/completeridehistory/ridehistorydetails/viewmodel/ride_history_viewmodel.dart';

import 'package:flutter_project11/features/yourprofiledetails/saveddetails/viewmodel/saved_details_viewmodel.dart';
import 'package:flutter_project11/features/yourprofiledetails/termconditions/viewmodel/terms_view_model.dart';
import 'package:flutter_project11/features/yourprofiledetails/yourprofile/view/yourprofile_view_screen.dart';
import 'package:provider/provider.dart';
import 'features/yourprofiledetails/yourprofile/viewmodel/yourprofile_view_model.dart';
import 'features/yourprofiledetails/privacydetails/viewmodel/privacy_view_model.dart';

import 'features/yourprofiledetails/helpsupport/viewmodel/help_support_view_model.dart';


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