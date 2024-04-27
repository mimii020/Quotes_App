import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quotes_app_final_version/core/services/quote_service.dart';
import 'package:quotes_app_final_version/ui/saved_quotes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late QuoteService quoteService;
  bool loading=false;
  @override
  void initState() {
   super.initState();
   quoteService=context.read<QuoteService>();
   getQuote();
   loadQuote();
  }
  getQuote() async{
    loading=true;
    await quoteService.getQuote();
    loading=false;
  }
  loadQuote() async{
    await quoteService.loadQuote();
  }
 
   saveQuote() async{
    await quoteService.saveQuote();
  }
 
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: [
            Consumer<QuoteService>(
              builder: (context,qteService,child){return Image.network(qteService.quote.quoteImage, fit: BoxFit.cover,);} 
            ),
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
                padding:const EdgeInsets.symmetric(horizontal: 20, vertical: 100)
                
            ),
            Consumer<QuoteService>(
              builder:(context,qteService,child) {
                return Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: '"',
                      style: const TextStyle(
                        color: Colors.green,
                        fontSize: 30,
                        fontWeight: FontWeight.w700,),
                      children:[TextSpan(
                            text:"${qteService.quote.quoteText}",
                            style:TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                              ),
                            children: [
                                 TextSpan(
                                    text:'"',
                                    style: TextStyle(
                                                color: Colors.green,
                                                fontSize: 30,
                                                fontWeight: FontWeight.w700,)
                                      
                                  )
                            ]
                    )
                      ]
                    )
                    
                    ),
                  Text(
                    '\n - ${qteService.quote.quoteAuthor} \n',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FloatingActionButton(
                          backgroundColor:Colors.blueGrey[900],
                          onPressed:(){saveQuote();},
                          heroTag: 'save',
                          child: Icon(Icons.add),
                          ),
                        FloatingActionButton(
                          backgroundColor:Colors.blueGrey[900],
                          onPressed: (){qteService.getQuote();},
                          heroTag: 'refresh',
                          child: Icon(Icons.refresh)
                          ),
                        FloatingActionButton(
                          backgroundColor:Colors.blueGrey[900],
                        //  onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>SavedQuotesScreen(qteService: quoteService)));},
                          onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>SavedQuotesScreen()));},
                          heroTag: 'storage',
                          child: Icon(Icons.sd_storage)
                          )
                      ],
                    ),
                  ),
                ],
              );} 
            )
          ],
        ),
      ),
    );
  }
}
