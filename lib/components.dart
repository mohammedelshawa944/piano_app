
void navigateTo(context, Widget) => Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context)=> Widget)
);

void navigatetoAndFinish(context , Widget)=> Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context)=> Widget),
        (Route<dynamic> route ){
      return false;
    }
);