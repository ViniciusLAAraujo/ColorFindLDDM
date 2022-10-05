import 'package:flutter/material.dart';
import 'package:color_find/home.dart';



class Page1 extends StatefulWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffe3d8db),
      child: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
              children:<Widget>[

                IconButton(
                  enableFeedback: false,
                  onPressed: () {
                  },
                  icon: const Icon(
                    Icons.info_outline,
                    color: Colors.black,
                    size: 50,
                  ),
                ),
                Text(
                  "Color find e uma iniciativa nascida de um projeto academico da disciplina de Laboratorio de Desenvolvimento Web. Temos por objetivo disponibilizar um aplicativo acessivel para que diversas pessoa possam facilmente encontrar o nome de uma cor a partir de uma foto.",
                  style: TextStyle(
                    color: Colors.grey[900],
                    fontSize: 45,
                    fontWeight: FontWeight.w500,
                  ),)
              ]

          ),
        ),
      ),
    );
  }
}

