import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_plus/iconsax_plus.dart';


class HomeNewUser extends StatelessWidget {
const HomeNewUser({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    // return Container();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Container(
          padding: EdgeInsets.all(8),
          child: Column( //column, row, stack usually use children
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(6),
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  border: Border.all(color: Color(0xffE1E6EC))
                ),
                child:             
                Image.asset(
                  'assets/images/logo2.png',
                  width: 2,
                ),
              ),
              SizedBox(height: 16),
              RichText(
                text: TextSpan(
                  text: '',
                  style: TextStyle(color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Hai Naufal, Yuk mulai pemindaian pertamamu menggunakan',
                      style: GoogleFonts.interTight(color: Color(0xff1b1b1b), fontSize: 24)
                    ),
                    TextSpan(
                      text: ' Disoriza AI ✨',
                      style: GoogleFonts.interTight(color: Color(0xff0B3E3F), fontSize: 24)
                    )
                  ]
                )
              ),
              SizedBox(height: 16),
              Text(
                'Ayo coba fitur pindai yang dimiliki aplikasi ini untuk mengetahui penyakit pada padi kamu.',
                style: GoogleFonts.interTight(
                  color: Color.fromRGBO(27, 27, 27, 0.60),
                  fontSize: 14
                )
              ),
              SizedBox(height: 24),
              ElevatedButton(onPressed: (){}, 
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(IconsaxPlusLinear.scanner, color: Colors.white,size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Pindai',
                    style: GoogleFonts.interTight(
                      color: Colors.white,
                      fontSize: 14
                    )
                  )
                ],
              ),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 44),
                backgroundColor: Color(0xffE3892D)
              )
              ),
              SizedBox(height: 12),
              GestureDetector(
                onTap: () {},
                child: Center(
                  child: Text(
                    'Lewati',
                    style: GoogleFonts.interTight(
                      color: Color(0xff7f7f7f),
                      fontSize: 14
                    )
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}