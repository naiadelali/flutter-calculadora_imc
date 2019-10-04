import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),    
  ));
}

class Home extends StatefulWidget {
  
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
 
  TextEditingController wtController = TextEditingController();
  TextEditingController htController = TextEditingController();
  String _infoText = "Informe seus dados!";
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  void _resetFields(){
      wtController.text="";
      htController.text="";
      setState(() {
         _infoText="Informe seus dados!";
      });
  } 

  void _calculate(){
    setState(() {
      double wt = double.parse(wtController.text);
      double ht = double.parse(htController.text) / 100;
      double imc = wt / (ht * ht);
      if( imc < 18.6){
        _infoText = "Abaixo do peso -> (${imc.toStringAsPrecision(2)})";
      } else if(imc >= 18.6 && imc <24.9){
         _infoText = "Peso Ideal -> (${imc.toStringAsPrecision(2)})";
      } else if(imc >= 24.9 && imc <29.9){
         _infoText = "Levemente acima do peso -> (${imc.toStringAsPrecision(2)})";
      } else if(imc >= 29.9 && imc < 34.9){
         _infoText = "Obesidade Grau I -> (${imc.toStringAsPrecision(2)})";
      } else if(imc >= 34.9 && imc < 39.9){
         _infoText = "Obesidade Grau II -> (${imc.toStringAsPrecision(2)})";
      } else if(imc >= 40){
         _infoText = "Obesidade Grau III -> (${imc.toStringAsPrecision(2)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var raisedButton = RaisedButton(
                      onPressed: (){
                        if(_formKey.currentState.validate()){
                          _calculate();
                        }
                      },
                      child: Text("Calcular", style: TextStyle(color: Colors.white, fontSize:25.0 ),),
                      color: Colors.purple,
                    );
        return Scaffold(
            appBar: AppBar(
              title: Text("Calculadora de IMC"),
              centerTitle: true,
              backgroundColor: Colors.purple,
              actions: <Widget>[
                IconButton(icon: Icon(Icons.refresh),
                  onPressed: _resetFields,
                )
              ],
            ),
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            child: Form(
                key: _formKey,
                child:   Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Icon(Icons.person_outline, size: 120.0, color: Colors.purple),
                    TextFormField(keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: "Peso (Kg)", 
                                                  labelStyle: TextStyle(color: Colors.purple)),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.purple, fontSize: 25.0),
                      controller: wtController,
                      validator: (value){
                        if(value.isEmpty){
                          return "Insira seu peso.";
                        }
                      },
                    ),
                    TextFormField(keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: "Altura", 
                                                  labelStyle: TextStyle(color: Colors.purple)),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.purple, fontSize: 25.0),
                      controller: htController,
                      validator: (value){
                        if(value.isEmpty){
                          return "Insira sua altura.";
                        }
                      }
                    ),
                    Padding(
                      padding: EdgeInsets.only(top:10.0, bottom: 10.0),
                      child: Container(
                        height: 50.0,
                        child: raisedButton,
                  ),
                ),
                Text(_infoText,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.purple, fontSize: 25.0),
                )
              ],
            ),
        ),
      ),
    );
  }
}