import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:pogoda_app/common/fetch_http_habs.dart';
import 'package:pogoda_app/model/hab_model.dart';

class ReadScreen extends StatefulWidget {
  final urlHab;

  ReadScreen({@required this.urlHab});

  @override
  _ReadScreenState createState() => _ReadScreenState();
}

class _ReadScreenState extends State<ReadScreen> {
  var _habModel = Hab();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Habr Reader'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: _getHab());
  }

  _getHab() {
    return FutureBuilder(
      future: _getHttpHab(),
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView(
            padding: EdgeInsets.only(
                left: 10.0, right: 10.0, top: 10.0, bottom: 40.0),
            children: [
              Text(
                '${_habModel.title}',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                '${_habModel.body}',
                style: TextStyle(fontSize: 18.0, color: Colors.black),
              ),
            ],
          );
        }
      },
    );
  }

  _getHttpHab() async {
    var response = await fetchHttpHabs(widget.urlHab);
    var _hab = parse(response.body);
    _habModel.title = _hab.getElementsByClassName('post__title post__title_full')[0].children[0].text;
    _habModel.body = _hab.getElementsByClassName('post__body post__body_full')[0].children[0].text;
    _habModel.hab_url = widget.urlHab;

    return _habModel;
  }
}
