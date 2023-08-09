import 'package:flutter/material.dart';
import 'package:funica/screens/home/components/default_appbar.dart';
import 'package:funica/screens/home/components/notification_card.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DefaultAppBar(
                title: 'Notification',
                trailing: InkWell(
                  onTap: (){},
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Center(
                      child: Icon(Icons.more_horiz_outlined),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 25),
              const Text('Today',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  )),
              const SizedBox(height: 15),
              const NotificationCard(),
              const SizedBox(height: 15),
              const Text('Yesterday',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  )),
              const SizedBox(height: 15),
              const NotificationCard(),
              const NotificationCard(),
              const SizedBox(height: 15),
              const Text('July 27, 2023',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  )),
              const SizedBox(height: 15),
              const NotificationCard(),
              const NotificationCard(),
              const NotificationCard(),
              const NotificationCard(),
            ],
          ),
        ),
      ),
    );
  }
}
/*
*
* SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    borderRadius: BorderRadius.circular(50),
                    child: const Icon(Icons.arrow_back),
                  ),
                  const SizedBox(width: 12),
                  const Text('Notification',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      )),
                  const Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Center(
                      child: Icon(Icons.more_horiz_outlined),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              const Text('Today',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  )),
              const SizedBox(height: 15),
              const NotificationCard(),
              const SizedBox(height: 15),
              const Text('Yesterday',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  )),
              const SizedBox(height: 15),
              const NotificationCard(),
              const NotificationCard(),
              const SizedBox(height: 15),
              const Text('July 27, 2023',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  )),
              const SizedBox(height: 15),
              const NotificationCard(),
              const NotificationCard(),
              const NotificationCard(),
              const NotificationCard(),
            ],
          ),
        ),
      ),
    );
* */