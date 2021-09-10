class SafeCaster {

  static O? tryCast<I,O>(I input) {
    try{
      return input as O;
    }catch(error){
      print("Error casting caused by : $error");
      return null;
    }
  }

  static O tryCastAndDefault<I,O>(I input, O defaultValue){
    try{
      return input as O;
    }catch(error){
      print("Error casting caused by : $error");
      return defaultValue;
    }
  }
}