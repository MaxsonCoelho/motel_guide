import 'package:flutter/material.dart';
import '../../models/motel_model.dart';
import '../suite/suite_list.dart';

class MotelItem extends StatefulWidget {
  final Motel motel;

  MotelItem(this.motel);

  @override
  _MotelItemState createState() => _MotelItemState();
}

class _MotelItemState extends State<MotelItem> {
  bool isFavorited = false;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: widget.motel.nome,
      child: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26, 
                                blurRadius: 6, 
                                spreadRadius: 2, 
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(widget.motel.imagem),
                            radius: 30,
                            backgroundColor: Colors.grey[300],
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.motel.nome,
                                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(widget.motel.bairro, style: TextStyle(fontSize: 14, color: Colors.black)),
                                  Text(
                                    '${widget.motel.distancia.toStringAsFixed(1)} km',
                                    style: TextStyle(fontSize: 12, color: Colors.blueGrey),
                                  ),
                                ],
                              ),

                              SizedBox(height: 4),
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.amber, width: 2),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(Icons.star, color: Colors.amber, size: 15),
                                        SizedBox(width: 4),
                                        Text(
                                          widget.motel.mediaAvaliacoes.toStringAsFixed(1),
                                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    "${widget.motel.qtdAvaliacoes} avaliações",
                                    style: TextStyle(fontSize: 12, color: Colors.black),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.keyboard_arrow_down, color: Colors.black, size: 15),
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 20,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isFavorited = !isFavorited;
                        });
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                        transform: isFavorited
                            ? Matrix4.identity().scaled(1.2)
                            : Matrix4.identity(),
                        child: Icon(
                          isFavorited ? Icons.favorite : Icons.favorite_rounded,
                          color: isFavorited ? Colors.red : Colors.grey,
                          size: 28,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SuiteList(suites: widget.motel.suites),
            ],
          ),
        ),
      ),
    );
  }
}
