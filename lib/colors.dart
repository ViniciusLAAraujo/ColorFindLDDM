
import 'package:flutter/material.dart';




class Page3 extends StatefulWidget {

  const Page3({Key? key}) : super(key: key);

  @override
  State<Page3> createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  bool _isAlwaysShown = true;

  bool _showTrackOnHover = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Scrollbar(
              isAlwaysShown: _isAlwaysShown,
              showTrackOnHover: _showTrackOnHover,
              hoverThickness: 30.0,
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) => MyItem(index),
              ),
            ),
          ),
          Divider(height: 1),
        ],
      ),
    );
  }
}

class MyItem extends StatelessWidget {
  final int index;

  const MyItem(this.index);

  @override
  Widget build(BuildContext context) {
    final color = Colors.primaries[index % Colors.primaries.length];
    final hexRgb = color.shade500.toString().substring(10, 16).toUpperCase();
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      leading: AspectRatio(
          aspectRatio: 1,
          child: Container(
            decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(100)
            ),

          )
      ),
      title: Text('Material Color #${index + 1}'),
      subtitle: Text('#$hexRgb'),
      trailing:Container(
        width:MediaQuery.of(context).size.width * 0.25,
        child: Row(
          children:[
            IconButton(
                onPressed: (){},
                icon: Icon(Icons.edit),
            ),
            IconButton(
                onPressed: (){},
                icon: Icon(Icons.delete_forever_outlined),
            )
          ]
        ),
      ),
    );
  }
}