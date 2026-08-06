import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  int currentPage = 0;
  final PageController controller = PageController();
  final List<Map<String, String>> pages = [
    {
      "image": "images/first.png",
      "title": "Set your schedule",
      "description":
      "Quickly see your upcoming events, tasks, conference calls, weather, and more.",
    },
    {
      "image": "images/first.png",
      "title": "Stay Organized",
      "description":
      "Manage your work and personal life in one beautiful place.",
    },
    {
      "image": "images/first.png",
      "title": "Get Started",
      "description":
      "Let's begin your productivity journey today.and puch your motivation to the next level.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(

            children: [
                Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  currentPage == 0 ? const SizedBox(width: 60) : TextButton(
                    onPressed: () {
                      controller.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.ease );},
                    child: const Text("Back",style: TextStyle(color: Colors.blue),),
                  ),

                  TextButton(
                    onPressed: () {
                      controller.animateToPage(
                        pages.length - 1,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.ease,
                      );
                    },
                    child: const Text("Skip",style: TextStyle(color: Colors.blue),),
                  ),
                ],
              ),
              Expanded(
                  child: PageView.builder(
                controller: controller,
                onPageChanged: (value) {
                  setState(() {
                    currentPage=value;
                  });
                },
                itemCount: pages.length,
                itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(

                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(pages[index]["image"]!, height: 300),
                   //Indicator
                     Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:
                          List.generate(pages.length,
                                  (index){
                                return Expanded(
                                  child: Container(
                                    height: 6,
                                    decoration: BoxDecoration(
                                      color: currentPage==index?Colors.blue:Colors.grey,
                                    ),
                                  ),
                                );
                              })),
                      const SizedBox(height: 20),
                      //Content
                      Text(
                        pages[index]["title"]!,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        pages[index]["description"]!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      SizedBox(height: 60,),
                    ]
                  ),
                );
              },)),
              MaterialButton(
                onPressed: (){
                  currentPage== pages.length-1 ? Navigator.pushReplacementNamed(context, '/home') : controller.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.ease,
                  );
                },child:Container(
                alignment: Alignment.center,
                child: Text(currentPage == pages.length - 1 ? "Get Started" : "Next",
                  style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Colors.white),),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(8),),
                height: 56,
              ),)
            ],

        ),
      ),
    ));

  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}