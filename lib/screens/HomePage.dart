import 'package:flutter/material.dart';
import 'package:divine_drapes/consts/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController search = TextEditingController();
  String? searchData;


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          Text("Divine Drapes",
              style: GoogleFonts.notoSans(
                  color: darkPurple, fontSize: 28, fontWeight: FontWeight.w700)),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.all(5),
                width: width*0.79,
                height: height*0.06,
                decoration: BoxDecoration(
                  border:Border.all(width: 2,color: Colors.black),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextField(
                  cursorColor: Colors.black,
                  cursorHeight: height*0.03,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none
                    ),
                    hintText: 'Search',
                    hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 18
                    ),
                    prefixIcon:Icon(
                      Icons.search,color: darkPurple,
                    ),
                  ),
                ),
              ),
              IconButton(
                padding: EdgeInsets.fromLTRB(0, 0, 0, height*0.025),
                onPressed: _showCategories,
                icon: Icon(
                  Icons.list,
                  size: height*0.079,
                ),
              ),
              SizedBox(
                width: width*0.03,
              ),
            ],
          ),
          SizedBox(
            height: 3,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text("Personalised gift for all occasions",
                style: GoogleFonts.notoSans(
                    color: Colors.black, fontSize: height*0.02, fontWeight: FontWeight.w700)),
          ),
          Expanded(
            child: GridView.count(
              physics: ScrollPhysics(),
              crossAxisCount: 3,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5.0,
              shrinkWrap: true,
              children: List.generate(
                9,
                (index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Container(
                          height: height*0.1,
                          width: width*0.23,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade600,
                                spreadRadius: 1,
                              )
                            ],
                            border: Border.all(width: 1),
                            image: DecorationImage(
                              image: NetworkImage(
                                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQHPMbZJr7SNw2hzsRGZ_0ro0tkIPezbONipQjzGKs2T07yCgJ5HM9_MbpBWs0NMx9v3j6NvRsnkbI&usqp=CAU&ec=48600113"),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                        ),
                        Text("Mugs",
                            style: GoogleFonts.notoSans(
                                color: Colors.black, fontSize: height*0.013, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(
            height: 3,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10,left: 12,top: 5),
            child: Text("Top selling",
                style: GoogleFonts.notoSans(
                    color: Colors.black, fontSize: height*0.02, fontWeight: FontWeight.w700)),
          ),
          Expanded(
            child: GridView.count(
              physics: ScrollPhysics(),
              crossAxisCount: 3,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5.0,
              shrinkWrap: true,
              children: List.generate(
                9,
                (index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Container(
                          height: height*0.1,
                          width: width*0.23,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade600,
                                spreadRadius: 1,
                              )
                            ],
                            border: Border.all(width: 1),
                            image: DecorationImage(
                              image: NetworkImage(
                                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQHPMbZJr7SNw2hzsRGZ_0ro0tkIPezbONipQjzGKs2T07yCgJ5HM9_MbpBWs0NMx9v3j6NvRsnkbI&usqp=CAU&ec=48600113"),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                        ),
                        Text("Mugs",
                            style: GoogleFonts.notoSans(
                                color: Colors.black, fontSize: height*0.013, fontWeight: FontWeight.w600)),                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
  Future<void> _showCategories() async {
    await showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          var size = MediaQuery.of(context).size;
          var height = size.height;
          var width = size.width;
          return AlertDialog(
            insetPadding: EdgeInsets.fromLTRB(8, height*0.09, 8, 5),
            scrollable: true,
            elevation: 2,
            // shadowColor: Colors.black,
            shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.black, width: 2),
                borderRadius: BorderRadius.circular(15.0,)),
            title: Row(
              children: [
                IconButton(onPressed: () {
                  Navigator.of(context).pop();
                }, icon: Icon(Icons.arrow_back_outlined,size: height*0.05,)
                ),
                SizedBox(width: 15,),
                Text("Categories",
                    style: GoogleFonts.notoSans(
                        color: Colors.black, fontSize: height*0.03, fontWeight: FontWeight.w700)),
              ],
            ),
            content: Container(
              height: height*0.575,
              width: width*0.82,
              child: ListView.builder(
                physics: ScrollPhysics(),
                itemCount: 20,
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.only(left: width*0.1,top: 10),
                  child: Text("Item $index",
                      style: GoogleFonts.notoSans(
                          color: Colors.black, fontSize: height*0.025, fontWeight: FontWeight.w500)),
                ),
              ),
            ),
          );
        });
  }
}


