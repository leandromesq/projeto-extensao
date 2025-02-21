import 'package:flutter/material.dart';
import 'package:rachadinha/core/utils/extensions/theme_context_extensions.dart';
import 'package:rachadinha/ui/home/widgets/home_app_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: context.colors.light,
        appBar: const HomeAppBar(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Divider(color: context.colors.primarygreen),
            const SizedBox(height: 24),
            SizedBox(
              width: 250,
              height: 80,
              child: TextField(
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 42, fontWeight: FontWeight.w500),
                cursorHeight: 50,
                showCursor: false,
                decoration: const InputDecoration(
                  hintText: 'ITEM',
                  hintStyle: TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                onChanged: (value) {},
              ),
            ),
            const SizedBox(height: 10),
            Row(
              spacing: 10,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  r'R$',
                  style: TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                    height: 60,
                    width: 150,
                    child: TextFormField(
                      style: const TextStyle(
                          fontSize: 32, fontWeight: FontWeight.w500),
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: context.colors.darkgreen,
                              width: 2.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: context.colors.darkgreen,
                              width: 2.0,
                            ),
                          )),
                    )),
                IconButton(
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  style: IconButton.styleFrom(
                    backgroundColor: context.colors.darkgreen,
                    iconSize: 50,
                    padding: EdgeInsets.zero,
                  ),
                  onPressed: () {},
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
