import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_midi/flutter_midi.dart';
import 'package:piano/piano.dart';
import 'package:url_launcher/url_launcher.dart';

class StartWid extends StatefulWidget {
  @override
  State<StartWid> createState() => _StartWidState();
}

class _StartWidState extends State<StartWid> {

  String? choice  ;

  var link ;


  @override
  void initState() {
    load('assets/Guitars.sf2');
    super.initState();
  }

  void load(String asset) async {
    FlutterMidi().unmute(); // Optionally Unmute
    ByteData _byte = await rootBundle.load(asset);
    FlutterMidi().prepare(sf2: _byte, name: 'assets/$choice.sf2'.replaceAll('assets/', ''));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Piano'),
        leading: DropdownButton(
            value: choice ?? 'Guitars',
            items: const [
              DropdownMenuItem(
                child: Text('Guitars'),
                value: 'Guitars',
              ),
              DropdownMenuItem(
                child: Text('Yamaha'),
                value: 'yamaha',
              ),
              DropdownMenuItem(
                child: Text('Expressive'),
                value: 'Expressive',
              )
            ], onChanged: (value) {
          setState(() {
            choice = value ;
          });
          load('assets/$choice.sf2');
        }),
        leadingWidth: 108,
        actions: [
          IconButton(onPressed: (){
           link = Uri.parse('tel : 123456');
          },
              icon: Icon(Icons.phone)),
          IconButton(onPressed: (){
            final Uri smsLaunchUri = Uri(
              scheme: 'sms',
              path: '0118 999 881 999 119 7253',
              queryParameters: <String, String>{
                'body': Uri.encodeComponent('Example Subject & Symbols are allowed!'),
              },
            );
          }, icon: Icon(Icons.sms)),
          IconButton(onPressed: (){}, icon: Icon(Icons.email)),
          IconButton(onPressed: (){}, icon: Icon(Icons.webhook))
        ],
      ),
      body: Center(
        child: InteractivePiano(
          highlightedNotes: [NotePosition(note: Note.C, octave: 3)],
          naturalColor: Colors.white,
          accidentalColor: Colors.black,
          keyWidth: 60,
          noteRange: NoteRange.forClefs([
            Clef.Treble,
          ]),
          onNotePositionTapped: (position) {
            FlutterMidi().playMidiNote(midi: position.pitch);
          },
        ),
      ),
    );
  }
}
