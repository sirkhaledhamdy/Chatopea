import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../styles/colors.dart';


Widget buildarticalItem(article, context) => InkWell(
  onTap: (){
  },
  child:   Padding(
    padding: const EdgeInsets.all(16.0),
    child: Row(
      children: [
        Container(
          width: 130.0,
          height: 120.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            image: DecorationImage(
              image: NetworkImage('${article['urlToImage']}',
              ),
  
  
              fit: BoxFit.cover,
            ),
          ),
  
        ),
        SizedBox(width: 20.0,),
        Expanded(
          child: Container(
            height: 120.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Text('${article['title']}',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                Text('${article['publishedAt']}',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    ),
  ),
);


Widget builderNews(list) => ListView.separated(
    physics: BouncingScrollPhysics(),
    itemBuilder: (context, index) => buildarticalItem(list[index], context),
    separatorBuilder: (context, index) => Padding(
      padding: const EdgeInsetsDirectional.only(start: 16.0),
      child: Container(
        height: 1,
        color: Colors.grey.shade300,
      ),
    ),
    itemCount: list.length);

Widget defaultButton ({
  double width = double.infinity,
  double minWidth = double.infinity,
  Color color = Colors.purple,
  Color textColor = Colors.purple,
  Color sideColor = Colors.purple,
  double elevation =  5.0,
  required void Function()? onPressed,
  required String text,
}) => Material(
  shape: RoundedRectangleBorder(
    side: BorderSide(
      color: sideColor,
    ),
    borderRadius:BorderRadius.circular(30.0),),
  clipBehavior: Clip.antiAlias,
  elevation: elevation,
  color: color,
  child:MaterialButton(
    minWidth: minWidth,
    onPressed: onPressed,
    child: Text(
      text.toUpperCase(),
      style: TextStyle(
        color: textColor,
      ),
    ),
  ),
);



Widget defaultFormField ({
  String? initialValue,
  required TextEditingController controller,
  required TextInputType type,
  void Function(String)? onSubmit,
  void Function(String)? onChange,
  required Function validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  bool isPass = false,
  void Function()? suffixPressed,
  String? errorText,
  String? hint,
}) => TextFormField(
  initialValue: initialValue,
  decoration: InputDecoration(
    hintText: hint,
    hintStyle: TextStyle(
      fontSize: 12,
    ),
    errorText: errorText,
    labelText: label,
    prefixIcon: Icon(
      prefix,
    ),
    suffixIcon: suffix != null ? IconButton(
      onPressed: suffixPressed,
      icon: Icon(
        suffix
      ),
    ) : null ,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(20.0)),
    ),
    enabledBorder:  OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.purple, width: 1.0),
      borderRadius: BorderRadius.all(Radius.circular(32.0)),
    ),
    focusedBorder:  OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.purple, width: 2.0),
      borderRadius: BorderRadius.all(Radius.circular(32.0)),
    ),
    contentPadding:
    EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  ),

  controller: controller,
  keyboardType: type,
  obscureText: isPass,
  onFieldSubmitted: onSubmit,
  validator: (value){
    if(value!.isEmpty) {
      return 'User Must Input Data';
    }
    return null;
  },
);

void navigateTo(context, widget)
{
  Navigator.push(context, MaterialPageRoute(builder:
  (context) => widget,
  ),);
}

void navigateAndFinish(context, widget)
{
  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
    builder: (context) => widget,
  ),
      (Route<dynamic> route) => false,
  );
}

void showToast({
  required String text,
  required ToastStates state,
}) => Fluttertoast.showToast(
  msg: text,
  toastLength: Toast.LENGTH_LONG,
  gravity: ToastGravity.BOTTOM,
  timeInSecForIosWeb: 5,
  backgroundColor: choseToastColor(state),
  textColor: Colors.white,
  fontSize: 16.0,
);

// enum
enum ToastStates {success , error, warning}

Color? choseToastColor(ToastStates state)
{
  Color color;
  switch(state)
  {
    case ToastStates.success:
      color = Colors.green.withOpacity(.8);
      break;
    case ToastStates.error:
      color =  Colors.red.withOpacity(.8);
      break;
    case ToastStates.warning:
      color =  Colors.orangeAccent.withOpacity(.8);
      break;
  }
  return color;
}


Widget buildFavouriteItem(model, context, {bool isOldPrice = true,}) => Padding(
  padding: const EdgeInsets.all(16.0),
  child: Container(
    height: 120,
    child: Row(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage(
                model.image,
              ),
              width: 120,
              height: 120,
            ),
            if (model.discount != 0 && isOldPrice == true)
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 5,
                ),
                child: Text(
                  'DISCOUNT',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                    backgroundColor: Colors.green,
                  ),
                ),
              )
          ],
        ),
        SizedBox(
          width: 20,
        ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14.0,
                    height: 1.3,
                  ),
                ),
                Spacer(),
                Row(
                  children: [
                    if (model.discount != 0 && isOldPrice == true)
                      Text(
                        model.oldPrice.toString(),
                        style: TextStyle(
                            fontSize: 10.0,
                            color: Colors.grey.shade500,
                            decoration: TextDecoration.lineThrough),
                      ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      model.price.toString(),
                      style: TextStyle(
                        fontSize: 12.0,
                        color: defaultColor,
                      ),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        // IconButton(
                        //   onPressed: () {
                            // ShopCubit.get(context)
                            //     .postFavouriteData(model!.id);
                          // },
                          // icon: CircleAvatar(
                          //   radius: 15,
                          //   backgroundColor: ShopCubit.get(context)
                          //       .favourites[model!.id] ==
                          //       true
                          //       ? defaultColor
                          //       : Colors.grey,
                          //   child: Icon(
                          //     Icons.favorite_outline,
                          //     color: Colors.white,
                          //     size: 16,
                          //   ),
                          // ),
                        // ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
      ],
    ),
  ),
);

PreferredSizeWidget? defaultAppBar({
  required BuildContext context,
  String title = '',
  List<Widget>? actions,

}) => AppBar(
  titleSpacing: 0.0,
  leading: IconButton(
    onPressed: ()
    {
      Navigator.pop(context);
    },
    icon: Icon(Icons.arrow_back_ios_new_outlined,),
  ),
  title: Text(
    title,
  ),
  actions: actions,
);


