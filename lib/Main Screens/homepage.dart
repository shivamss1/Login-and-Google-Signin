import 'package:exam/Services/carservice.dart';
import 'package:exam/models/carmodel.dart';
import 'package:flutter/material.dart';

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Material(
      child: Column(
        children: [
          SizedBox(
            height: size.height * 0.2,
            width: size.width,
            child: FutureBuilder(
              future: Cardataservice().carlist(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.connectionState == ConnectionState.done) {
                  List<CarModel> carlist = snapshot.data as List<CarModel>;
                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: carlist.length,
                      itemBuilder: (context, index) {
                        return Container(
                            margin: EdgeInsets.all(size.width * 0.02),
                            child: Image.asset(carlist[index].image));
                      });
                }
                return Container();
              },
            ),
          ),
          SizedBox(
            height: size.height * 0.27,
            width: size.width,
            child: FutureBuilder(
              future: Cardataservice().carlist(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.connectionState == ConnectionState.done) {
                  List<CarModel> carlist = snapshot.data as List<CarModel>;
                  return ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: carlist.length,
                      itemBuilder: (context, index) {
                        return Container(
                            margin: EdgeInsets.all(size.width * 0.02),
                            child: Image.asset(
                              carlist[index].image,
                              fit: BoxFit.cover,
                            ));
                      });
                }
                return Container();
              },
            ),
          ),
          Container(
            height: size.height * 0.35,
            width: size.width,
            margin: EdgeInsets.only(top: size.height * 0.01),
            child: FutureBuilder(
              future: Cardataservice().carlist(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.connectionState == ConnectionState.done) {
                  List<CarModel> carlist = snapshot.data as List<CarModel>;
                  return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        childAspectRatio: 3 / 2,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 20,
                      ),
                      itemCount: carlist.length,
                      itemBuilder: (context, index) {
                        return Container(
                            margin: EdgeInsets.all(size.width * 0.02),
                            child: Image.asset(
                              carlist[index].image,
                              fit: BoxFit.cover,
                            ));
                      });
                }
                return Container();
              },
            ),
          )
        ],
      ),
    );
  }
}
