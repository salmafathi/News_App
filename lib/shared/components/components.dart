import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/screens/webview/webview.dart';

Widget articleItem (Map article,context){

  return InkWell(
    onTap: (){
      navigateTo(context, WebViewScreen(article['url']));
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0 , horizontal: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image: DecorationImage(
                  image: article['urlToImage'] == null ?   NetworkImage('https://www.book.mn/uploads/book_author/nopic.jpg') : NetworkImage('${article['urlToImage']}'),
                  fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 20.0,),
          Expanded(
            child: Container(
              height: 100.0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${article['title']}',
                    style: Theme.of(context).textTheme.bodyText1,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 10.0,),
                  Text('${article['publishedAt']}',
                    style: TextStyle(
                      fontSize: 11.0,
                      color: Colors.grey,
                    ),)
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget separateItem ()=> Container(height: 1.0 , width: double.infinity,color: Colors.grey[300],);


Widget defaultTextFormField({
  required TextEditingController controller,
  required TextInputType keyboardType,
  required String labelText,
  required String? Function(String?)? validator,
  Icon? prefixIcon,
  Icon? suffixIcon,
  ValueChanged<String>? onSubmit,
  Function(String)? onChange,
  bool obscureText = false,
  VoidCallback? suffixFun,
  Function()? onTap,
}) =>
    TextFormField(
      validator: validator,
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon != null ? IconButton(icon: suffixIcon, onPressed: suffixFun,) : null ,
      ),
      keyboardType: keyboardType,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      obscureText: obscureText,
    );



void navigateTo(context,widget) => Navigator.push(
    context,
    MaterialPageRoute(builder: (context)=>widget));