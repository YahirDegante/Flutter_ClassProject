import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: Text("Primer textPrimer textPrimer textPrimer textPrimer text")),
                SizedBox(width: 16.0),
                Expanded(child: Text("Primer text")),
                SizedBox(width: 16.0),
                Expanded(child: Text("Primer textPrimer textPrimer textPrimer text")),
                SizedBox(width: 16.0),
                Expanded(child: Text("Primer texttext")),
              ],
            ),
          ],
        ),
      ),
      */
      body: SafeArea(
        child: Column(
          children: [
            const Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.account_circle_outlined),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Cristopher Soto Ventura",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Hace 10 minutos",
                      style: TextStyle(color: Colors.black45, fontSize: 12.0),
                    ),
                  ],
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.more_vert),
                )
              ],
            ),
            Image.network('https://media.istockphoto.com/id/1147544807/vector/thumbnail-image-vector-graphic.jpg?s=612x612&w=0&k=20&c=rnCKVbdxqkjlcs3xH87-9gocETqpspHFXu5dIGB4wuM='),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(Icons.favorite_border),
                  Icon(Icons.message_outlined),
                  Icon(Icons.send_and_archive_outlined),
                  Spacer(),
                  Icon(Icons.bookmark_outline)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
