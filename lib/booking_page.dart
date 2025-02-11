// booking_page.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BookingPage extends StatelessWidget {

  const BookingPage({Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen[100],
      appBar: buildAppBar(context),
      body: BookingForm(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40.0),
          bottomRight: Radius.circular(40.0),
        ),
      ),
      leading: buildAppBarLeading(context),
      title: Text(
        'Booking details',
        style: GoogleFonts.sourceCodePro(
          textStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          color: Colors.green[700],
        ),
      ),
    );
  }

  Widget buildAppBarLeading(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 2,
              offset: Offset(1, 4),
            ),
          ],
          borderRadius: BorderRadius.circular(100),
          color: Colors.teal[700],
        ),
        child: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.lightGreen[100]),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}

class BookingForm extends StatefulWidget {

  const BookingForm({Key? key})
      : super(key: key);

  @override
  _BookingFormState createState() => _BookingFormState();
}

class _BookingFormState extends State<BookingForm> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    } else if (value.length != 10) {
      return 'Phone number must be 10 digits';
    } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'Invalid characters in phone number';
    }
    return null; // Return null if the input is valid
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                cursorColor: Colors.teal,
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  labelStyle: GoogleFonts.sourceCodePro(
                    textStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                    color: Colors.green,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                validator: _validatePhone,
                decoration: InputDecoration(
                  labelText: 'Phone number',
                  labelStyle: GoogleFonts.sourceCodePro(
                    textStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                    color: Colors.green,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'e-mail(optional)',
                  labelStyle: GoogleFonts.sourceCodePro(
                    textStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                    ),
                    color: Colors.green,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100)),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: MaterialButton(
                  onPressed: () {
                    // Call a function to save the details to Firebase
                    saveDetailsToFirebase(context);
                  },
                  height: 55,
                  minWidth: 150.0,
                  color: Colors.teal[700],
                  textColor: Colors.lightGreen[100],
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                  child: Text(
                    'Complete',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                      color: Colors.lightGreen[100],
                    ),
                  ),
                ),
              ),
            ),
        
          ],
        ),
      ),
    );
  }

  void saveDetailsToFirebase(BuildContext context) async {
    try {
      // Retrieve order details from the Provider

      // Retrieve user details from the form
      final String name = nameController.text;
      final String phone = phoneController.text;
      final String shopName = emailController.text;
      String? phoneError = _validatePhone(phone);

      if (phoneError != null) {
        // Show an error message and return, preventing saving to Firebase
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(phoneError),
          duration: Duration(seconds: 2),
        ));
        return;
      }
      // Save both user details and order details to Firebase
      CollectionReference orders =
      FirebaseFirestore.instance.collection('bookings');

      await orders.doc(name).set({
        'userDetails': {
          'name': name,
          'phone': phone,
          'shopName': shopName,
        },
      });

      print('Order confirmed. Document ID: $name');

      // You can add any additional logic here, such as clearing the cart

      // Navigate back to the home page after confirming the consignment
      Navigator.pop(context);
    } catch (e) {
      print('Error confirming order: $e');
      // Handle the error as needed
    }
  }


}
