import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home.dart'; // Import the Home class

class HomeViewPage extends StatelessWidget {
  final Home home;

  HomeViewPage({required this.home});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[100],
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(00.0),
                  bottomRight: Radius.circular(500.0),
                ),
              ),
              backgroundColor: Colors.orange[100],
              expandedHeight: 400.0,
              floating: true,
              flexibleSpace: FlexibleSpaceBar(
                background: PageView.builder(
                  itemCount: home.images.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => Dialog(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0), // Adjust the radius here
                              child: Image.network(
                                home.images[index],
                                fit: BoxFit.cover,
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
                              ),
                            ),
                          ),
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20.0), bottomRight: Radius.circular(20.0)), // Adjust the radius here
                        child: Image.network(
                          home.images[index],
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ];
        },
        body: Container(
          decoration: BoxDecoration(
            color: Colors.orange[100],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(0.0),
              topRight: Radius.circular(100.0),
            ),
          ),
          child: ListView(
            padding: EdgeInsets.all(16.0),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${home.name}',
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                    color: Colors.green[900],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(
                  '${home.size}',
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    color: Colors.lime[700],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(
                  '${home.location}',
                  style: GoogleFonts.redHatDisplay(
                    textStyle: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    color: Colors.black54,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Center(
                  child: Text(
                    'Amenities:',
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                      color: Colors.green,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 10, bottom: 20),
                child: Text(
                  home.amenities,
                  style: GoogleFonts.sourceCodePro(
                    textStyle: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    color: Colors.black54,
                  ),
                ),
              ),
              Center(
                child: Text(
                  'Ksh ${home.rent}',
                  style: GoogleFonts.sourceCodePro(
                    textStyle: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                    color: Colors.green[300],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(50.0),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/booking');
                  },
                  height: 55,
                  minWidth: 150.0,
                  color: Colors.green,
                  textColor: Colors.teal,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                  child: Text(
                    'Book Viewing',
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      color: Colors.orange[100],
                    ),
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
