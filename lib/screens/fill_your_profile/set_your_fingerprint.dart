import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gif/flutter_gif.dart';
import 'package:funica/components/loading.dart';
import 'package:funica/components/my_button.dart';
import 'package:funica/controller/gif_image.dart';
import 'package:funica/route/app_route.dart';
import 'package:funica/screens/fill_your_profile/components/default_appbar.dart';
import 'package:local_auth/local_auth.dart';

class SetYourFingerprint extends StatefulWidget {
  const SetYourFingerprint({super.key});

  @override
  State<SetYourFingerprint> createState() => _SetYourFingerprintState();
}

class _SetYourFingerprintState extends State<SetYourFingerprint> {
  Future<void> _authenticate() async {
    final LocalAuthentication auth = LocalAuthentication();
    // ···
    final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
    final bool canAuthenticate =
        canAuthenticateWithBiometrics || await auth.isDeviceSupported();

    final List<BiometricType> availableBiometrics =
        await auth.getAvailableBiometrics();

    if (availableBiometrics.isNotEmpty) {
      // Some biometrics are enrolled.
    }

    if (availableBiometrics.contains(BiometricType.strong) ||
        availableBiometrics.contains(BiometricType.face)) {
      // Specific types of biometrics are available.
      // Use checks like this with caution!
    }

    try {
      final bool didAuthenticate = await auth.authenticate(
          localizedReason: 'Please authenticate to show account balance',
          options: const AuthenticationOptions(biometricOnly: true));
      print("Authorized successfully");
    } on PlatformException {
      // ...
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: kToolbarHeight, left: 20, right: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const DefaultAppbar(
            icon: Icon(Icons.arrow_back),
            title: 'Set Your Fingerprint',
          ),
          const Text(
            'Add a fingerprint to make your account more secure.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          const Icon(
            Icons.fingerprint,
            size: 240,
          ),
          const Text(
            'Please put your finger on the fingerprint scanner to get started.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: MyButton(
                  theme: 'light',
                  title: 'Skip',
                  onTap: () {

                  },
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: MyButton(
                  theme: 'dark',
                  title: 'Continue',
                  onTap: () {
                    // _authenticate();
                    Loading(
                      where: AppRoute.dashboard,
                    );
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height /
                MediaQuery.of(context).size.height,
          ),
        ],
      ),
    );
  }
}

/*Future<void> _authenticate() async {
      var localAuth = LocalAuthentication();
      bool canCheckBiometrics = await localAuth.canCheckBiometrics;

      if (canCheckBiometrics) {
        bool didAuthenticate = await localAuth.authenticate(
          localizedReason: 'Please authenticate to view your account',
        );

        if (didAuthenticate) {
          print('Authenticated successfully');
          // Navigate to next screen or perform the operation needed after successful authentication
        } else {
          print('Failed to authenticate');
          // Handle the scenario when the user failed to authenticate
        }
      } else {
        print('Biometrics not available');
        // Handle the scenario when biometrics is not available
      }
    }*/
