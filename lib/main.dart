// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue, // Adjust color scheme as needed
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String selectedFactory = "Factory 2"; // Initially selected factory
  final List<String> factories = ["Factory 1 (UNREACHABLE)", "Factory 2"]; // Update factory list with "(UNREACHABLE)" for Factory 1
  bool isEngineerPage = false;

  void onSelectedFactory(String factory) {
    if (factory == "Factory 1 (UNREACHABLE)") {
      // Simulate connecting (could involve network calls)
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          selectedFactory = "Factory 2"; // Update displayed factory
        });
      });
    } else {
      setState(() {
        selectedFactory = factory;
      });
    }
  }

  void navigateToEngineerPage() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const EngineerPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedFactory),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: factories.map((factory) => FactoryButton(
                text: factory.split('(')[0].trim(), // Extract factory name without "(UNREACHABLE)"
                onPressed: (factory) => onSelectedFactory(factory),
                isSelected: factory == selectedFactory,
                isUnreachable: factory.contains('UNREACHABLE'), // Set isUnreachable based on factory text
              )).toList(),
            ),
            Visibility(
              visible: selectedFactory != "Factory 1", // Hide for Factory 1
              child: SensorReadingsCard(factory: selectedFactory),
            ),
            const Text(
              "Total Power Consumption: 1549.7 kW",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Text("Last updated: 2024-05-11 00:00"),
          ],
        ),
      ),

        bottomNavigationBar: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: "Engineers"),
              BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
            ],
            currentIndex: 0,
            onTap: (index) => {
            if (index == 0) {
            // navigate to home screen
            } else if (index == 1) {
            navigateToEngineerPage()
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SettingsPage()),
      ),
    }
  },
    ),
    );
  }
}


class NotificationSettingsPage extends StatefulWidget {
  const NotificationSettingsPage({super.key});

  @override
  _NotificationSettingsPageState createState() => _NotificationSettingsPageState();
}

class _NotificationSettingsPageState extends State<NotificationSettingsPage> {
  bool _steamPressureNotificationsEnabled = true;
  bool _steamFlowNotificationsEnabled = true;
  bool _waterLevelNotificationsEnabled = true;
  bool _powerFrequencyNotificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notification Settings"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              "Factory 1",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SwitchListTile(
              title: const Text("Steam Pressure"),
              value: _steamPressureNotificationsEnabled,
              onChanged: (value) => setState(() => _steamPressureNotificationsEnabled = value),
            ),
            SwitchListTile(
              title: const Text("Steam Flow"),
              value: _steamFlowNotificationsEnabled,
              onChanged: (value) => setState(() => _steamFlowNotificationsEnabled = value),
            ),
            SwitchListTile(
              title: const Text("Water Level"),
              value: _waterLevelNotificationsEnabled,
              onChanged: (value) => setState(() => _waterLevelNotificationsEnabled = value),
            ),
            SwitchListTile(
              title: const Text("Power Frequency"),
              value: _powerFrequencyNotificationsEnabled,
              onChanged: (value) => setState(() => _powerFrequencyNotificationsEnabled = value),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String selectedFactory = "Factory 1";
  final List<String> factories = ["Factory 1", "Factory 2"];

  void onSelectedFactory(String factory) {
    setState(() {
      selectedFactory = factory;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Factory Selection
            Row(
              children: factories.map((factory) => FactoryButton(
                text: factory,
                onPressed: onSelectedFactory,
                isSelected: factory == selectedFactory,
              )).toList(),
            ),
            const SizedBox(height: 16.0), // Add spacing

            // Sensor Readings
            SensorReadingsCard(factory: selectedFactory),
            const SizedBox(height: 16.0), // Add spacing

            // Total Power Consumption
            const Text(
              "Total Power Consumption: 1549.7 kW",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0), // Add smaller spacing

            // Last Updated
            const Text("Last updated: 2024-05-11 00:00"),
          ],
        ),
      ),
    );
  }
}


class EngineerPage extends StatelessWidget {
  const EngineerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Enter Phone Number"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const TextField(
              decoration: InputDecoration(
                labelText: "Phone Number",
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Add functionality here
              },
              child: const Text("Get Activation Code"),
            ),
          ],
        ),
      ),
    );
  }
}

class ActivationPage extends StatefulWidget {
  const ActivationPage({super.key});

  @override
  _ActivationPageState createState() => _ActivationPageState();
}

class _ActivationPageState extends State<ActivationPage> {
  String activationCode = "";

  void onCodeChanged(String value) {
    setState(() {
      activationCode = value;
    });
  }

  void submitActivationCode() {
    // Replace with your actual logic to submit the activation code
    // This could involve network calls or other actions
    // ignore: avoid_print
    print("Submitting activation code: $activationCode");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Activate Account"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: "Activation Code",
              ),
              onChanged: onCodeChanged,
            ),
            ElevatedButton(
              onPressed: submitActivationCode,
              child: const Text("Get Activation Code"),
            ),
          ],
        ),
      ),
    );
  }
}


class FactoryButton extends StatelessWidget {
  final String text;
  final Function(String) onPressed;
  final bool isSelected;
  final bool isUnreachable; // Added flag for unreachable state

  const FactoryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isSelected = false,
    this.isUnreachable = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => onPressed(text),
      style: TextButton.styleFrom(
        backgroundColor: isUnreachable ? Colors.white : (isSelected ? Colors.blue : null),
        foregroundColor: isUnreachable ? Colors.blue : (isSelected ? Colors.white : Colors.blue),
      ),
      child: Row(
        children: [
          Text(text),
        ],
      ),
    );
  }
}

class SensorReadingsCard extends StatelessWidget {
  final String factory;
  final List<ListTile> sensorReadings = []; // Initialize with empty list

  SensorReadingsCard({super.key, required this.factory});

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              title: Text("Steam Pressure"),
              trailing: Text("120.5 psi"),
            ),
            ListTile(
              title: Text("Steam Flow"),
              trailing: Text("350.2 m³/h"),
            ),
            ListTile(
              title: Text("Water Level"),
              trailing: Text("78.4%"),
            ),
            ListTile(
              title: Text("Power Frequency"),
              trailing: Text("50.0 Hz"),
            ),
          ],
        ),
      ),
    );
  }
}