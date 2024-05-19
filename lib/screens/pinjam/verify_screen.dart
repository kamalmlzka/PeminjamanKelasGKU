import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:peminjaman_kelas_gku/screens/home_screen.dart";
import "/widgets/build_ticket_ui.dart";
// import "package:ticket_widget/ticket_widget.dart";

import "/model/model_pinjam.dart";
import "/widgets/ddm.dart";
import "/widgets/button.dart";
// import "/widgets/build_report_details.dart";
// import "/widgets/ui/ticket_painter.dart";

class VerifyScreen extends StatefulWidget {
  final ModelPinjam modelPinjam;

  const VerifyScreen({required this.modelPinjam, super.key});

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  void backToHome() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return DDM(
      title: 'Selamat!!',
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Pinjam Ruangan",style: GoogleFonts.poppins(fontWeight:FontWeight.bold,fontSize:20),),
              const SizedBox(height: 10),
              Text("Peminjaman Kamu Telah Di Ajukan",style: GoogleFonts.ebGaramond(fontWeight:FontWeight.bold,fontSize:20),),
              const SizedBox(height: 10),
              TicketUI(modelPinjam: widget.modelPinjam),
              Button(actionOnButton: backToHome, buttonText: "Home")
            ],
          ),
        ),
      ),
    );
  }
}
