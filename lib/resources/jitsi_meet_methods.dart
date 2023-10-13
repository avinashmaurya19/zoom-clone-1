// import 'package:flutter/material.dart';
// import 'package:jitsi_meet_wrapper/jitsi_meet_wrapper.dart';
// import 'package:zoom_clone_1/resources/auth_methods.dart';

// class JitsiMeetMethods {
//   final AuthMethods _authMethods = AuthMethods();
//   Map<String, Object> featureFlags = {};

//   void createMeeting({
//     required String roomName,
//     required bool isAudioMuted,
//     required bool isVideoMuted,
//     String username = '',
//   }) async {
//     try {
//       String name;
//       if (username.isEmpty) {
//         name = _authMethods.user.displayName!;
//       } else {
//         name = username;
//       }
//       var options = JitsiMeetingOptions(
//         roomNameOrUrl: roomName,
//         userDisplayName: name,
//         userEmail: _authMethods.user.email,
//         serverUrl: _authMethods.user.photoURL,
//         isAudioOnly: isAudioMuted,
//         isVideoMuted: isVideoMuted,
//         featureFlags: featureFlags,
//       );
//       debugPrint("JitsiMeetingOptions: $options");

//       await JitsiMeetWrapper.joinMeeting(
//         options: options,
//         // listener: JitsiMeetingListener(
//         //   onOpened: () => debugPrint("onOpened"),
//         //   onConferenceWillJoin: (url) {
//         //     debugPrint("onConferenceWillJoin: url: $url");
//         //   },
//         //   onConferenceJoined: (url) {
//         //     debugPrint("onConferenceJoined: url: $url");
//         //   },
//         //   onConferenceTerminated: (url, error) {
//         //     debugPrint("onConferenceTerminated: url: $url, error: $error");
//         //   },
//         //   onAudioMutedChanged: (isMuted) {
//         //     debugPrint("onAudioMutedChanged: isMuted: $isMuted");
//         //   },
//         //   onVideoMutedChanged: (isMuted) {
//         //     debugPrint("onVideoMutedChanged: isMuted: $isMuted");
//         //   },
//         //   onChatToggled: (isOpen) =>
//         //       debugPrint("onChatToggled: isOpen: $isOpen"),
//         //   onClosed: () => debugPrint("onClosed"),
//         // ),
//       );
//     } catch (e) {
//       print("error: $e");
//     }
//   }
// }

import 'package:flutter/material.dart';
import 'package:jitsi_meet_wrapper/jitsi_meet_wrapper.dart';
import 'package:zoom_clone_1/resources/auth_methods.dart';
import 'package:zoom_clone_1/resources/firestore_methods.dart';

class JitsiMeetMethods {
  final AuthMethods _authMethods = AuthMethods();
  Map<String, Object> featureFlags = {};
  final FirestoreMethods _firestoreMethods = FirestoreMethods();

  void createMeeting({
    required String roomName,
    required bool isAudioMuted,
    required bool isVideoMuted,
    String username = '',
  }) async {
    try {
      String name;
      if (username.isEmpty) {
        name = _authMethods.user.displayName!;
      } else {
        name = username;
      }

      var options = JitsiMeetingOptions(
        roomNameOrUrl: roomName,
        userDisplayName: name,
        userEmail: _authMethods.user.email,
        isAudioMuted: isAudioMuted,
        isVideoMuted: isVideoMuted,
        userAvatarUrl: _authMethods.user.photoURL,
        featureFlags: featureFlags,
      );

      _firestoreMethods.addToMeetingHistory(roomName);
      await JitsiMeetWrapper.joinMeeting(options: options);
    } catch (error) {
      debugPrint("error: $error");
    }
  }
}
