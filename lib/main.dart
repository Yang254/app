import 'home.dart'; // Import the Home class
import 'home_view_page.dart';
import 'splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'booking_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(), // Set SplashScreen as the home screen
      routes: {
        '/homepage': (context) => HomeScreen(),
        '/booking': (context) => BookingPage(),
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedLocation = 'Thika'; // Default location
  final List<String> locations = [
    'Thika', 'Nairobi', 'Mombasa', 'Kisumu', 'Embu', 'Eldoret', 'Kitale', 'Nakuru'
  ]; // Add your locations here

  Future<void> _refresh() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.lightGreen[100],
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: DropdownButton<String>(
              value: selectedLocation,
              elevation: 0,
              borderRadius: BorderRadius.circular(20),
              dropdownColor: Colors.lightGreen[100],
              icon: Icon(Icons.location_on, color: Colors.black),
              onChanged: (String? newValue) {
                setState(() {
                  selectedLocation = newValue!;
                });
              },
              items: locations.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                      color: Colors.orange[600],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection(selectedLocation).snapshots(),
          builder: (context, snapshot) {

            if (snapshot.connectionState == ConnectionState.waiting) {

              return Center(
                child: Lottie.asset(
                  'assets/loading1.json',
                  height: 200,
                  width: 300,
                ),
              );
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(child: Text('No homes found'));
            }

            final homes = snapshot.data!.docs.map((doc) {
              return Home(
                images: List<String>.from(doc['images']),
                name: doc['name'],
                size: doc['size'],
                location: doc['location'],
                rent: doc['rent'],
                amenities: doc['amenities'],
              );
            }).toList();

            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                mainAxisSpacing: 20.0,
                childAspectRatio: 1.0109,
              ),
              itemCount: homes.length,
              itemBuilder: (context, index) {
                return HomeCard(home: homes[index]);
              },
            );
          },
        ),
      ),
    );
  }
}

class HomeCard extends StatelessWidget {
  final Home home;

  const HomeCard({Key? key, required this.home}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomeViewPage(home: home),
          ),
        );
      },
      child: Card(
        color: Colors.lightGreen[100],
        elevation: 0.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200.0,
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 200.0,
                  enlargeCenterPage: true,
                  enableInfiniteScroll: false,
                  autoPlay: true,
                ),
                items: home.images.map((imageUrl) {
                  return Builder(
                    builder: (BuildContext context) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(30.0),
                        child: Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width,
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 15, top: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      home.name,
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                        color: Colors.green[900],
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      home.size,
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                        color: Colors.lime[700],
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      home.location,
                      style: GoogleFonts.redHatDisplay(
                        textStyle: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                        color: Colors.black54,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Ksh ${home.rent}',
                      style: GoogleFonts.sourceCodePro(
                        textStyle: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                        color: Colors.green[300],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
