// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:quotes_app_final_version/core/services/quote_service.dart';

class SavedQuotesScreen extends StatefulWidget {
  //final QuoteService qteService;

  const SavedQuotesScreen({
    Key? key,
    //required this.qteService,
  }) : super(key: key);

  @override
  State<SavedQuotesScreen> createState() => _SavedQuotesScreenState();
}

class _SavedQuotesScreenState extends State<SavedQuotesScreen> {
  
  @override  
  void initState(){
    super.initState();
    loadQuote();
  }
   void loadQuote() async {
    await Provider.of<QuoteService>(context, listen: false).loadQuote();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        
        floatingActionButton:   FloatingActionButton(
              backgroundColor: Colors.blueGrey[900],
              onPressed: (){Navigator.pop(context);},
              child: Icon(Icons.arrow_back),
              ) ,
        body: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: [
            Container(
               alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0, 0.6, 1],
                    colors: [
                      Colors.blueGrey[800]!.withAlpha(70),
                      Colors.blueGrey[800]!.withAlpha(220),
                      Colors.blueGrey[800]!.withAlpha(255),
                    ],
                  ),
                ),
                padding:const EdgeInsets.symmetric(horizontal: 20, vertical: 100),
                
                  
          ),
          
              
             Consumer<QuoteService>(
              builder: (context, qteServices, child) {
                 return ListView.builder(
                  itemCount: qteServices.savedQuotes.length,
                  itemBuilder: (context,index)=>Container(
                    
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      border:Border.all(color: Colors.black),
                      color: Colors.white,
                      ),
                    child: ListTile(
                        title: Column (
                            children:[
                            Text(
                                '${qteServices.savedQuotes[index].quoteAuthor}',
                                style: TextStyle(
                                  fontWeight:FontWeight.w500,
                                  fontSize: 30,
                                ),
                              ),
                              
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 16),
                                child: Text(
                                  '"${qteServices.savedQuotes[index].quoteText}"',
                                  style: TextStyle(
                                    fontSize: 22,
                                    ),
                                ),
                              ),
                            ]
                          )
                        )
                          
                        )
                        );
              }
             ),
                    
                    
                    
            
               
          ],
          
              )
              ),
            
          
        );

      
      
  }
}