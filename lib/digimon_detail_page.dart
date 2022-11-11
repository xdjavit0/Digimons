import 'package:flutter/material.dart';
import 'digimon_model.dart';
import 'dart:async';

class DigimonDetailPage extends StatefulWidget {
  final Digimon digimon;
  DigimonDetailPage(this.digimon);

  @override
  _DigimonDetailPageState createState() => _DigimonDetailPageState();
}

class _DigimonDetailPageState extends State<DigimonDetailPage> {
  final double digimonAvarterSize = 150.0;
  double _sliderValue = 10.0;

  Widget get addYourRating {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                flex: 1,
                child: Slider(
                  activeColor: Color(0xFF0B479E),
                  min: 0.0,
                  max: 10.0,
                  value: _sliderValue,
                  onChanged: (newRating) {
                    setState(() {
                      _sliderValue = newRating;
                    });
                  },
                ),
              ),
              Container(
                  width: 50.0,
                  alignment: Alignment.center,
                  child: Text(
                    '${_sliderValue.toInt()}',
                    style: TextStyle(color: Colors.black, fontSize: 25.0),
                  )),
            ],
          ),
        ),
        submitRatingButton,
      ],
    );
  }

  void updateRating() {
    if (_sliderValue < 5) {
      _ratingErrorDialog();
    } else {
      setState(() {
        widget.digimon.rating = _sliderValue.toInt();
      });
    }
  }

  Future<Null> _ratingErrorDialog() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error!'),
            content: Text("Come on! They're good!"),
            actions: <Widget>[
              TextButton(
                child: Text('Try Again'),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          );
        });
  }

  Widget get submitRatingButton {
    return ElevatedButton(
      onPressed: () => updateRating(),
      child: Text('Submit'),
    );
  }

  Widget get digimonImage {
    return Hero(
      tag: widget.digimon,
      child: Container(
        height: digimonAvarterSize,
        width: digimonAvarterSize,
        constraints: BoxConstraints(),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              const BoxShadow(
                  offset: const Offset(1.0, 2.0),
                  blurRadius: 2.0,
                  spreadRadius: -1.0,
                  color: const Color(0x33000000)),
              const BoxShadow(
                  offset: const Offset(2.0, 1.0),
                  blurRadius: 3.0,
                  spreadRadius: 0.0,
                  color: const Color(0x24000000)),
              const BoxShadow(
                  offset: const Offset(3.0, 1.0),
                  blurRadius: 4.0,
                  spreadRadius: 2.0,
                  color: const Color(0x1f000000))
            ],
            image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(widget.digimon.imageUrl??''))),
      ),
    );
  }

  Widget get rating {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.star,
          size: 40.0,
          color: Colors.black,
        ),
        Text('${widget.digimon.rating}/10',
            style: TextStyle(color: Colors.black, fontSize: 30.0))
      ],
    );
  }

  Widget get digimonProfile {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 32.0),
      decoration: BoxDecoration(
        color: Color(0xFFABCAED),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          digimonImage,
          Text('${widget.digimon.name}',
              style: TextStyle(color: Colors.black, fontSize: 32.0)),
          Text('${widget.digimon.levelDigimon}',
              style: TextStyle(color: Colors.black, fontSize: 20.0)),
          Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: rating,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFABCAED),
      appBar: AppBar(
        backgroundColor: Color(0xFF0B479E),
        title: Text('Meet ${widget.digimon.name}'),
      ),
      body: ListView(
        children: <Widget>[digimonProfile, addYourRating],
      ),
    );
  }
}
