import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../models/item.dart';

class ItemCard extends StatelessWidget {
  final Item item;
  const ItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Column(
      children: [
        const Spacer(),
        const Spacer(),
        const Spacer(),
        const Spacer(),
        SizedBox(
          height: h * 0.50,
          width: w,
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: Lottie.asset(
              item.lottie,
              fit: BoxFit.cover,
            ),
            // child: Placeholder(
            //   color: Colors.black,
            // ),
          ),
        ),
        const Spacer(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: w * 0.08),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: h * 0.18,
                // child: const Placeholder(),
                child: Text(
                  item.title,
                  maxLines: 3,
                  style: GoogleFonts.poppins(fontSize: 35, fontWeight: FontWeight.w700, color:Colors.teal[900]),
                ),
              ),

              Text(
                selectionColor: Colors.black87,
                item.description,
                style: GoogleFonts.montserrat(fontSize: 15, fontWeight: FontWeight.w500, color:Colors.black87  ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}