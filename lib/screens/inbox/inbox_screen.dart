import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({Key? key}) : super(key: key);

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 22),
                width: double.infinity,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.grey))),
                child: TabBar(
                  // isScrollable: true,
                  unselectedLabelColor: Colors.black,
                  labelColor: Colors.red,
                  indicatorColor: Colors.red,
                  automaticIndicatorColorAdjustment: true,
                  tabs: [
                    Tab(
                      text: 'message'.tr,
                    ),
                    Tab(
                      text: 'notifications'.tr,
                    ),
                  ],
                  controller: _tabController,
                  indicatorSize: TabBarIndicatorSize.tab,
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    ///tab 1
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ListView(shrinkWrap: true, children: [
                        Image.asset(
                          'asset/message-inbox.png',
                          height: 100,
                          width: 100,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Invite Friends & Earn Extra Money',
                          style: TextStyle(
                              color: Color(0xFF222222),
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              letterSpacing: 0.5,
                              height: 1),
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        const Text(
                          'In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before final copy is available',
                          style: TextStyle(
                              color: Color(0xFF555555),
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              letterSpacing: 0.5,
                              height: 1.7),
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        const Divider(),
                        const SizedBox(
                          height: 14,
                        ),
                        Image.asset(
                          'asset/message-inbox.png',
                          height: 100,
                          width: 100,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Invite Friends & Earn Extra Money',
                          style: TextStyle(
                              color: Color(0xFF222222),
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              letterSpacing: 0.5,
                              height: 1),
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        const Text(
                          'In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document ',
                          style: TextStyle(
                              color: Color(0xFF555555),
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              letterSpacing: 0.5,
                              height: 1.7),
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                      ]),
                    ),

                    ///tab 2
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ListView(shrinkWrap: true, children: [
                        Image.asset(
                          'asset/message-inbox.png',
                          height: 100,
                          width: 100,
                        ),
                        const  SizedBox(
                          height: 10,
                        ),
                        const Text('Invite Friends & Earn Extra Money', style: TextStyle(color: Color(0xFF222222), fontWeight: FontWeight.w500, fontSize: 18, letterSpacing: 0.5, height: 1),),
                        const SizedBox(height: 14,),
                        const Text(
                          'In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before final copy is available',
                          style: TextStyle(
                              color: Color(0xFF555555),
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              letterSpacing: 0.5,
                              height: 1.7),
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        const Divider(),
                        const SizedBox(
                          height: 14,
                        ),
                        Image.asset(
                          'asset/message-inbox.png',
                          height: 100,
                          width: 100,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const  Text(
                          'Invite Friends & Earn Extra Money',
                          style: TextStyle(
                              color: Color(0xFF222222),
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              letterSpacing: 0.5,
                              height: 1),
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        const Text(
                          'In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document ',
                          style: TextStyle(
                              color: Color(0xFF555555),
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              letterSpacing: 0.5,
                              height: 1.7),
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                      ]),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
