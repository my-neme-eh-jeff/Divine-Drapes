import 'package:flutter/material.dart';
import 'package:divine_drapes/consts/constants.dart';

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
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            'Divine Drapes',
            style: TextStyle(
                color: darkPurple, fontSize: 30, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.all(5),
                width: 250,
                height: 40,
                child: TextField(
                  controller: search,
                  onChanged: (value) {
                    searchData = search.text;
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(color: Colors.black, width: 3),
                    ),
                    hintText: 'Search',
                  ),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.list,
                  size: 50,
                ),
              ),
              SizedBox(
                width: 10,
              ),
            ],
          ),
          SizedBox(
            height: 3,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              "Personalised gift for all occasions",
              style: TextStyle(fontSize: 20),
            ),
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
                          height: 65,
                          width: 65,
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
                        Text("Mugs"),
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
            padding: const EdgeInsets.all(12.0),
            child: Text(
              "Top Selling",
              style: TextStyle(fontSize: 20),
            ),
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
                          height: 65,
                          width: 65,
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
                        Text("Mugs"),
                      ],
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
}
