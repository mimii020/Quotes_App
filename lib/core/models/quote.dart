class Quote{
   late String quoteText;
   late String quoteAuthor;
   late String quoteImage;
  Quote({required this.quoteText,required this.quoteAuthor, required this.quoteImage});
  //this is to deal with the JSON data bch nhawlouha lel objects of quote class
  Quote.fromMap(Map<String,dynamic> map){
    quoteText=map['quoteText'];
    quoteAuthor=map['quoteAuthor'];
  }

  toMap(){
    return {
      'quoteText':quoteText,
      'quoteAuthor':quoteAuthor,
    };
  }
}