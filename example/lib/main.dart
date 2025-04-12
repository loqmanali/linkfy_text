import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:linkfy_text/linkfy_text.dart';

void main() {
  runApp(const MyApp());
}

final k = GlobalKey<ScaffoldMessengerState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'linkfy_text Demo',
      scaffoldMessengerKey: k,
      debugShowCheckedModeBanner: false,
      home: const App(),
    );
  }
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final textStyle =
      GoogleFonts.spaceGrotesk(fontSize: 16, fontWeight: FontWeight.w400);

  final List<Map<String, dynamic>> texts = [
    {
      "text":
          "O1. Testing hyphenated domains: https://my-website.com and http://sub-domain.example-site.com",
      "types": null
    },
    {
      "text": "O2. This text contains an email address: example@app.com",
      "types": [LinkType.email]
    },
    {
      "text": "O3. This text contains an #hashtag",
      "types": [LinkType.hashTag]
    },
    {
      "text": "O4. This text contains a @user tag",
      "types": [LinkType.userTag]
    },
    {
      "text": "O5. This text contains a phone number: (555) 444 2223",
      "types": [LinkType.phone]
    },
    {
      "text":
          "O6. Testing complex URLs: https://my-complex-domain.com/path?param=value and https://sub-domain.my-site.com/test",
      "types": [
        LinkType.phone,
        LinkType.email,
        LinkType.url,
        LinkType.hashTag,
        LinkType.userTag,
      ]
    },
  ];

  void showSnackbar(String msg) {
    k.currentState!.removeCurrentSnackBar();
    k.currentState!.showSnackBar(SnackBar(
      content: Text(msg, style: textStyle),
      behavior: SnackBarBehavior.floating,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(27.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Text(
                "LinkfyText Example",
                style: textStyle.copyWith(
                  fontSize: 24,
                ),
              ),
            ),
            for (var i = 0; i < texts.length; i++)
              Padding(
                  padding: const EdgeInsets.only(top: 14),
                  child: LinkifyText(
                    texts[i]['text'],
                    textAlign: TextAlign.left,
                    linkTypes: texts[i]['types'],
                    textStyle: textStyle,
                    customLinkStyles: const {
                      LinkType.email: TextStyle(color: Colors.blue),
                      LinkType.hashTag: TextStyle(color: Colors.green),
                      LinkType.userTag: TextStyle(color: Colors.deepPurple),
                      LinkType.url: TextStyle(color: Colors.pink),
                      LinkType.phone: TextStyle(color: Colors.deepOrange),
                    },
                    linkStyle: textStyle.copyWith(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                    onTap: (link) => showSnackbar(
                        "link pressed: ${link.value!}. Type: ${link.type}"),
                  )),
          ],
        ),
      ),
    );
  }
}
