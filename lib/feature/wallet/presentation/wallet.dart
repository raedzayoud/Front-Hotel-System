import 'package:flutter/material.dart';
import 'package:hotel/constant.dart';
import 'package:hotel/core/utils/assets.dart';
import 'package:hotel/core/utils/responsive.dart';

class Wallet extends StatelessWidget {
  const Wallet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            height: 70,
          ),
          Center(
            child: Container(
              height: AppResponsive.heigth(context) * .4,
              width: AppResponsive.width(context) * .8,
              color: Colors.white,
              child: Row(
                children: [
                  Image.asset(AssetsImage.wallet),
                  Column(
                    children: [
                      Text(
                        "Your Wallet",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        "\$0",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MaterialButton(
                shape:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                height: 60,
                onPressed: () {},
                child: Text(
                  "50",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 17),
                ),
                color: Colors.blue,
              ),
              MaterialButton(
                shape:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                height: 60,
                onPressed: () {},
                child: Text(
                  "100",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 17),
                ),
                color: Colors.blue,
              ),
              MaterialButton(
                shape:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                height: 60,
                onPressed: () {},
                child: Text(
                  "200",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 17),
                ),
                color: Colors.blue,
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          MaterialButton(
            shape: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            height: 50,
            minWidth: AppResponsive.width(context) * .9,
            color: Colors.black,
            onPressed: () {},
            child: Text(
              "Add Money",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            child: Column(
              children: [
                SizedBox(height: 10,),
                Text("Your Trancsation",style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20
                ),),
              ],
            ),
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50))),
            width: double.infinity,
            height: AppResponsive.heigth(context) * .9,
          )
        ],
      ),
    );
  }
}
