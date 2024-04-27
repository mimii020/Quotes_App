import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:quotes_app_final_version/core/models/quote.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';



class QuoteService extends ChangeNotifier{
  final dio=Dio();
  List <Quote> savedQuotes=[];
  late Quote quote=Quote(quoteAuthor: '',quoteText: '',quoteImage: '');
  Future<void> getQuote() async {
    final response=await dio.get('http://api.forismatic.com/api/1.0/?method=getQuote&format=json&lang=en');
    if (response.statusCode==200){
      quote=Quote.fromMap(response.data);
      await getImage(quote.quoteAuthor);
    }
    notifyListeners();
  }
  
  getImage(name) async {
    var image=await dio.get("https://en.wikipedia.org/w/api.php?action=query&generator=search&gsrlimit=1&prop=pageimages%7Cextracts&pithumbsize=400&gsrsearch=$name&format=json");
    try{
      var result=image.data["query"]["pages"];
      result=result[result.keys.first];
      quote.quoteImage=result["thumbnail"]["source"];
    } catch(e){
      quote.quoteImage="";
    }
    notifyListeners();
  }

  Future saveQuote() async{
       final preferences=await SharedPreferences.getInstance();
       if((savedQuotes.contains(quote))==false){
        savedQuotes.add(quote);
        var quoteList=savedQuotes.map((quote)=>jsonEncode(quote.toMap())).toList();
        preferences.setStringList('quote', quoteList);
      

       }
       
       notifyListeners();
  }

  Future loadQuote() async{
    final preferences=await SharedPreferences.getInstance();
    List<String>? quoteList= preferences.getStringList('quote');
    if(quoteList!=null){
       savedQuotes=quoteList.map((quoteJSON)=>Quote.fromMap(jsonDecode(quoteJSON))).toList();
    }
    
  }
}