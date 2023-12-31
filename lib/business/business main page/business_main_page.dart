import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:neabuy/business%20management/GraphsAnalyticsScreen.dart';
import 'package:neabuy/business%20management/order%20management/order_management_screen.dart';
import 'package:neabuy/business/business%20main%20page/business%20profile/business_profile_screen.dart';

void main() {
  runApp(MaterialApp(
    home: BusinessMainPage(),
  ));
}

class BusinessMainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Business Dashboard'),
        backgroundColor: const Color(0xFF2980B9),
        automaticallyImplyLeading: false, // Remove the back button
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Other sections
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: <Widget>[
                CardButton(
                  title: 'Incoming Orders',
                  onPressed: () {
                    // Show a dialog when the button is pressed
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CupertinoAlertDialog(
                          title: Text("Incoming Order"),
                          content: Text("You have a new order from a customer."),
                          actions: <Widget>[
                            CupertinoDialogAction(
                              child: Text("OK"),
                              onPressed: () {
                                Navigator.of(context).pop(); // Close the dialog
                                // Navigate to the Order Management screen
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => OrderManagementScreen()),
                                );
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),

                const SizedBox(height: 16.0), // Add spacing
                // Use a GridView.builder for Inventory Management and Order Management
                GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16.0, // Add spacing horizontally
                    mainAxisSpacing: 16.0, // Add spacing vertically
                    childAspectRatio: 1.6, // Adjust the aspect ratio to reduce the size
                  ),
                  shrinkWrap: true,
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return _RoundedBox(
                      child: CardButton(
                        title: index == 0
                            ? 'Inventory Management'
                            : 'Order Management',
                        onPressed: () {
                          // Navigate to Inventory Management or Order Management
                          if (index == 0) {
                            // Navigate to Inventory Management
                          } else {
                            // Navigate to Order Management
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => OrderManagementScreen()),
                            );
                          }
                        },
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16.0), // Add spacing
                // Wrap the CustomGraphWidget with Expanded to push it up
                Expanded(
                  child: CustomGraphWidget(),
                ),
                // Add more sections here
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        selectedItemColor: const Color(0xFF2980B9),
        onTap: (int index) {
          // Handle bottom navigation bar item taps here
          if (index == 0) {
            // Navigate to the home page or perform other actions
          } else if (index == 1) {
            // Navigate to the profile page
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfileScreen()), // Replace with your profile screen widget
            );
          }
        },
      ),
    );
  }
}

class _RoundedBox extends StatelessWidget {
  final Widget child;

  const _RoundedBox({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: child,
    );
  }
}

class CardButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const CardButton({
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      margin: const EdgeInsets.all(0), // No margin here
      child: InkWell(
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Center( // Center the button title
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2980B9),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
