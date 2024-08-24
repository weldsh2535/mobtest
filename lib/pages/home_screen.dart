import 'package:customer/bloc/customers/customer_bloc.dart';
import 'package:customer/bloc/customers/customer_event.dart';
import 'package:customer/bloc/customers/customer_state.dart';
import 'package:customer/core/app_colors.dart';
import 'package:customer/models/customer_model.dart';
import 'package:customer/pages/login.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
   List<User> newsModelList = [];
   ScrollController scrollController = ScrollController();
  final ScrollController _scrollController = ScrollController();
   String searchTerm = "";
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CustomerBloc>(context).add(GetCustomerEvent());
    return Scaffold(
      appBar: AppBar(
         backgroundColor:  AppColors.black ,
        title: const Text("Customer List",style: TextStyle(color: AppColors.white),),
        centerTitle: true,
        actions:  [
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen(),));
            },
            child: const Icon(Icons.logout,color: AppColors.white ))
        ],
      ),
      body: BlocBuilder<CustomerBloc, CustomerState>(
        builder: (context, state) {
          if (state is CustomerStateLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is CustomerStateSucess) {
           List<User>? blList = state.data;
            newsModelList = state.data
                .where((element) =>
                    element.firstname
                        .toLowerCase()
                        .contains(searchTerm.toLowerCase().toString()) ||
                    element.lastname
                        .toString()
                        .contains(searchTerm.toLowerCase().toString()) )
                .toList();
            return newsModelList.isEmpty
                ? const Center(
                    child: Text("No user found!!"),
                  )
                : InteractiveViewer(
                    scaleEnabled: false,
                    constrained: false,
                    child: Scrollbar(
                      controller: _scrollController,
                      child: SingleChildScrollView(
                          controller: scrollController,
                          // scrollDirection: Axis.horizontal,
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * .9,
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              children: [
                                
                 const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .8,
                      child: Card(
                        color: const  Color.fromARGB(255, 34, 99, 75),
                        child: Container(
                          margin: const EdgeInsets.only(left: 20, right: 5),
                          height: 70,
                      
                          child:  Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                               const Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "Customer",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16.0),
                                  ),
                                  Icon(
                                    Icons.bar_chart_outlined,
                                    color: Colors.white,
                                    size: 35,
                                  )
                                ],
                              ),
                              Text(
                                newsModelList.length.toString(),
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 30.0),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ]
                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * .7,
                                  child: DataTable2(
                                    columnSpacing: 12,
                                    horizontalMargin: 12,
                                    minWidth: 900,
                                    columns: const <DataColumn>[
                                     
                                      DataColumn(
                                        label: Text(
                                          "First Name",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                      ),
                                      DataColumn(
                                          label: Text("Last Name",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18))),
                                      DataColumn(
                                          label: Text("Phone",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18))),
                                      DataColumn(
                                          label: Text(
                                              "Email",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18))),
                                      DataColumn(
                                          label: Text("Address",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18))),
                                    ],
                                    rows: List<DataRow>.generate(
                                        newsModelList.length,
                                        (index) => DataRow(
                                                color: MaterialStateProperty
                                                    .resolveWith<Color?>(
                                                  (Set<MaterialState> states) {
                                                    // Use the index to determine if the row is even or odd
                                                    if (index.isEven) {
                                                      return Colors
                                                          .lightBlue[100];
                                                    } else {
                                                      return Colors.white;
                                                    }
                                                  },
                                                ),
                                                cells: [
                                                  DataCell(Text(
                                                      newsModelList[index].firstname)),
                                                  DataCell(Text(
                                                          newsModelList[index]
                                                              .lastname
                                                              .toString())
                                                  ),
                                                  DataCell( Text(
                                                          newsModelList[index]
                                                              .phone
                                                              .toString()),),
                                                  DataCell(Text(
                                                      "${newsModelList[index].email}"
                                                          .toString())),
                                                  DataCell(Text(
                                                      "${newsModelList[index].address}"
                                                          .toString())),
                                                  
                                                ])),
                                  ),
                                ),
              //                 Container(
              // width: MediaQuery.of(context).size.width * 0.9, // Set the width dynamically
              // margin: const EdgeInsets.only(top: 30),
              // child: NumberPagination(
              //   onPageChanged: (int pageNumber) {
              //     // Update the state or perform actions based on page change
              //     setState(() {
              //       selectedPageNumber = pageNumber;
              //     });
              //   },
              //   pageTotal: state.boloCustomer.next  != null ? (selectedPageNumber + 1) : selectedPageNumber, // Ensure this calculation reflects the actual total pages
              //   pageInit: selectedPageNumber, // Initialize the pagination to the current page
              //   colorPrimary: Colors.white,
              //   colorSub: Colors.grey,
              // ),)
                              ],
                            ),
                          )),
                    ),
                  );
          }
          return   const Center(child: Text("No Customer"));
        },
      ),
    );
  }
}
