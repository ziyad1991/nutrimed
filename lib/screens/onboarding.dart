import 'package:flutter/material.dart';
import './login.dart';
import '../provider/auth_provider.dart';
import '../provider/visits_provider.dart';
import 'package:provider/provider.dart';

class onboarding extends StatefulWidget  {
  static const routeName = '/onBoard';

  @override
  _onboardingState createState() => _onboardingState();
}

class _onboardingState extends State<onboarding> {
  int currentPage = 0;
  final PageController _pageController =  PageController(
      initialPage: 0,
      keepPage: true
  );
  @override
  Widget build(BuildContext context) {

    final AuthData = Provider.of<AuthProvider>(context);
    final VisitData = Provider.of<VisitsProvider>(context);
    return Scaffold(
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.6,
                child: PageView(
                  controller: _pageController,
                  children: [
                    onBoardPage("onboard1", "Nutrimed HRM","Manage your tasks"),
                    onBoardPage("onboard2", "Tasks Schedule","Find All of your duties in one place"),
                    onBoardPage("onboard3", "Manage Requests","Send Your requests to the supervisor"),
                  ],
                  onPageChanged: (value)=>{setCurrentPage(value)},
                ),
              ),

            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              margin: const EdgeInsets.only(top: 20),
              height: 300,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/path1.png'),
                      fit: BoxFit.fill
                  )
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: openLoginPage,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 100),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              offset: const Offset(0,9),
                              blurRadius: 20,
                              spreadRadius: 3
                          )]
                      ),
                      child: const Text("Get Started", style: TextStyle(
                          fontSize: 16
                      ),),
                    ),
                  ),
                  const SizedBox(height: 50,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(3, (index) => getIndicator(index)),
                  )
                ],

              ),
            ),
          )
        ],
      ),
    );




  }
  AnimatedContainer getIndicator(int pageNu)
  {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      height: 10,
      width: (currentPage == pageNu) ? 20 : 10,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          color: (currentPage == pageNu) ? Colors.black : Colors.grey
      ),
    );
  }
  Column onBoardPage(String img, String title, String newtext)
  {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          height: 20,
        ),
        Container(
          height: 200,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(50),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/$img.png')
              )
          ),
        ),
        const SizedBox(height: 50,),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(title, style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w500
          ),),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
          child:  Text(newtext, style: TextStyle(
              fontSize: 16,
              color: Colors.grey
          ),textAlign: TextAlign.center,),
        )
      ],
    );
  }
  setCurrentPage(int value)
  {
    currentPage = value;
    setState(() {

    });
  }
  openLoginPage()
  {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
  }
}