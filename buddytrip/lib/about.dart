import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class About extends StatefulWidget {
  const About({super.key});

  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController feedbackController = TextEditingController();

  void _submitFeedback() {
    if(nameController.text.isEmpty || emailController.text.isEmpty || feedbackController.text.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('fill all the fields!'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
      ),
    );
    }
    else if(nameController.text.isNotEmpty && emailController.text.isNotEmpty && feedbackController.text.isNotEmpty && !emailController.text.contains('@')){
      ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Invalid Email'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
      ),
    );
    }
    else if(nameController.text.isNotEmpty && emailController.text.isNotEmpty && feedbackController.text.isNotEmpty && emailController.text.contains('@')){
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Feedback submitted successfully!'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );

    // Clear the text fields
    nameController.clear();
    emailController.clear();
    feedbackController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              const Text(
                'Welcome to BuddyTrip!',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: 'IrishGrover',
                ),
              ),
              const SizedBox(height: 10),
              
              // Description
              Container(
                width: double.infinity,
                child: const Text(
                  "BuddyTrip is your ultimate travel companion, designed to make trip planning and coordination effortless. "
                  "Whether you're exploring new destinations or managing group travel, BuddyTrip ensures a smooth experience "
                  "with real-time collaboration, route optimization, and seamless communication.",
                  style: TextStyle(fontSize: 16),
                  softWrap: true,
                ),
              ),
              const SizedBox(height: 20),

              // Animation
              Center(
                child: Lottie.asset(
                  'assets/travel.json', 
                  width: 250,
                  height: 250,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(height: 20),

              // Feature List
              const Text(
                'Why Choose BuddyTrip?',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              ListTile(
                leading: const Icon(Icons.room, color: Colors.blue),
                title: const Text('Convenient Bookings'),
                subtitle: const Text('Find the best hotels for your stay.'),
              ),
              ListTile(
                leading: const Icon(Icons.place, color: Colors.green),
                title: const Text('Recommendations'),
                subtitle: const Text('Recommendations for popular spots'),
              ),
              ListTile(
                leading: const Icon(Icons.wallet, color: Colors.purple),
                title: const Text('Expense Tracking'),
                subtitle: const Text('Manage trip expenses and split costs.'),
              ),
              ListTile(
                leading: const Icon(Icons.help_center, color: Colors.orange),
                title: const Text('Seamless Communication and Support'),
                subtitle: const Text('24/7 help available'),
              ),

              const SizedBox(height: 20),

              // Feedback Section
              const Text(
                'We value your feedback!',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Your Name',
                  prefixIcon: const Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Your Email',
                  prefixIcon: const Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              TextField(
                controller: feedbackController,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: 'Your Feedback',
                  prefixIcon: const Icon(Icons.feedback),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Submit Button
              Center(
                child: ElevatedButton.icon(
                  onPressed: _submitFeedback,
                  label: const Text('Submit'),
                  icon: const Icon(Icons.send, color: Color.fromARGB(255, 22, 68, 23),),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    textStyle: const TextStyle(fontSize: 14),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
