import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class Termsandcondition extends StatelessWidget {
  const Termsandcondition({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Terms & Conditions',
          style: TextStyle(color: Colors.grey),
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            )),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const Text(
              '1. ACCEPTANCE OF TERMS',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 10),
            const Text(
              'By accessing and using the workout app, you agree to be bound by these terms and conditions, as well as our privacy policy.',
              style: TextStyle(fontSize: 14),
            ),
            TextButton(
                onPressed: () {
                  Get.to(const PrivaceyPolicey());
                },
                child: const Text('Privacy Policey')),
            const SizedBox(height: 20),
            const Text(
              '2. USE OF APP',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 10),
            const Text(
              'You may use the app for your personal, non-commercial use only. You may not modify, copy, distribute, transmit, display, perform, reproduce, publish, license, create derivative works from, transfer, or sell any information, software, products or services obtained from the app.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 20),
            const Text(
              '3. ACCOUNT REGISTRATION',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 10),
            const Text(
              'To use certain features of the app, you may need to create an account. You agree to provide accurate and complete information when registering for an account, and to keep your account information up-to-date. You are responsible for maintaining the confidentiality of your account login credentials and for all activities that occur under your account.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 20),
            const Text(
              '4. CONTENT AND INTELLECTUAL PROPERTY',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 10),
            const Text(
              'All content and materials available on the app, including but not limited to text, graphics, logos, images, videos, and software, are the property of the app or its licensors and are protected by copyright, trademark, and other intellectual property laws. You may not use, copy, reproduce, modify, distribute, transmit, display, publish, sell, license, or create derivative works from any such content or materials.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 20),
            const Text(
              '5. DISCLAIMER OF WARRANTIES',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 10),
            const Text(
              'The app is provided on an "as is" and "as available" basis, without any warranties of any kind, either express or implied. The app does not guarantee that the app will be error-free, uninterrupted, or free of viruses or other harmful components. The app is not responsible for any damage to your device or loss of data that may result from your use of the app.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 20),
            const Text(
              '6. LIMITATION OF LIABILITY',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 10),
            const Text(
              'The app shall not be liable for any direct, indirect, incidental, special, or consequential damages arising out of or in connection with your use of the app, including but not limited to damages for loss of profits, goodwill, use, data, or other intangible losses..',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 20),
            const Text(
              '7. MODIFICATIONS TO TERMS AND APP',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 10),
            const Text(
              'The app reserves the right to modify these terms and conditions and the app at any time, without notice. Your continued use of the app after such modifications will constitute your agreement to be bound by the modified terms and conditions.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 20),
            const Text(
              '8. GOVERNING LAW AND JURISDICTION',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 10),
            const Text(
              'These terms and conditions shall be governed by and construed in accordance with the laws of [insert jurisdiction]. Any dispute arising out of or in connection with these terms and conditions shall be subject to the exclusive jurisdiction of the courts of [insert jurisdiction].',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 20),
            const Text(
              'By using this app, you agree to these terms and conditions. If you do not agree to these terms and conditions, do not use the app.',
              style: TextStyle(color: Colors.deepOrange, fontSize: 12),
            ),
            // Add more sections as needed
          ],
        ),
      ),
    );
  }
}

class PrivaceyPolicey extends StatelessWidget {
  const PrivaceyPolicey({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Privacy Policey',
          style: TextStyle(color: Colors.grey),
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            )),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: const [
            Text(
              '1. Information We Collect',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'We may collect information from you when you use our app, including your name, email address, and workout information. We may also collect information automatically, such as your device type, IP address, and usage data.',
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 20),
            Text(
              '2. How We Use Your Information',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'We may use the information we collect from you to personalize your workout experience, improve our app, and communicate with you about our services. We may also share your information with third-party service providers that help us operate our app.',
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 20),
            Text(
              '3. Cookies and Similar Technologies',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'We may use cookies and similar technologies to collect information about your use of our app and to improve your experience. You can manage your cookie settings in your device or browser settings.',
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 20),
            Text(
              '4. Third-Party Links',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'Our app may contain links to third-party websites or services that are not owned or controlled by us. We are not responsible for the privacy practices of these third-party websites or services. We encourage you to review the privacy policies of these third-party websites or services before providing any personal information',
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 20),
            Text(
              '5. Children`s Privacy',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'Our app is not intended for children under the age of 13. We do not knowingly collect personal information from children under the age of 13. If you are under the age of 13, please do not use our app or provide any personal information to us.',
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 20),

            Text(
              '6. Changes to This Privacy Policy',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'We may update our privacy policy from time to time. We will notify you of any changes by posting the new privacy policy on this page. You are advised to review this privacy policy periodically for any changes.',
              style: TextStyle(fontSize: 14),
            ),

            SizedBox(height: 10),
            Text(
              'If you have any questions about our privacy policy, please contact us at [insert your contact information].',
              style: TextStyle(color: Colors.deepOrange, fontSize: 12),
            ),
            // Add more sections as needed
          ],
        ),
      ),
    );
  }
}
