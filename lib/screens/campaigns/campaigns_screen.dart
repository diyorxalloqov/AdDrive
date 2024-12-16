import 'dart:convert';
import 'package:dio/dio.dart' as dio; // Alias the dio package
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:flutter_texi_tracker/screens/campaigns/content/campaign_car_widget.dart';
import 'package:flutter_texi_tracker/widgets/no_data_found_widget.dart';
import 'package:flutter_texi_tracker/controller/auth_controller.dart';
import 'package:flutter_texi_tracker/model/campaignListModel.dart';
import '../../model/hive_model/user_model.dart';

class CampaignsScreen extends StatefulWidget {
  const CampaignsScreen({super.key});

  @override
  _CampaignsScreenState createState() => _CampaignsScreenState();
}

class _CampaignsScreenState extends State<CampaignsScreen> {
  CampaignListModel? campaignListResponse;
  bool isLoading = false;
  final AuthController authController = Get.put(AuthController());

  /// ==== get campaign list method ====////
  Future<void> getCampaignList() async {
    dio.Dio dioInstance = dio.Dio();
    setState(() {
      isLoading = true;
    });

    User? user = authController.getUser();
    String? token = user?.accessToken;

    if (token == null) {
      setState(() {
        isLoading = false;
      });
      return;
    }
    try {
      final response = await dioInstance.get(
        'https://dashboard.wrapyt.com/api/driver/campaign-list',
        options: dio.Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200) {
        if (response.data is String) {
          final jsonResponse = jsonDecode(response.data);
          setState(() {
            campaignListResponse = CampaignListModel.fromJson(jsonResponse);
            isLoading = false;
          });
        } else if (response.data is Map<String, dynamic>) {
          setState(() {
            campaignListResponse = CampaignListModel.fromJson(response.data);
            isLoading = false;
          });
        }
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      debugPrint('Error: $e');
    }
  }

  /// ==== send join post request ====///
  Future<void> sendJoinRequest(int campaignId) async {
    const url = 'https://dashboard.wrapyt.com/api/driver/join-request';
    User? user = authController.getUser();
    String? token = user?.accessToken;
    dio.Dio dioInstance = dio.Dio();
    try {
      dio.Response response = await dioInstance.post(
        url,
        data: {"campaign_id": campaignId.toString()},
        options: dio.Options(
          headers: {
            "Content-Type": "application/json",
            'Authorization': 'Bearer $token'
          },
          validateStatus: (status) {
            return status != null;
          },
        ),
      );
      if (response.statusCode == 200) {
        if (response.data['success'] == true) {
          Fluttertoast.showToast(msg: '${response.data['message']}');
        } else if (response.data['success'] == false) {
          Fluttertoast.showToast(msg: '${response.data['message']}');
        } else {
          Fluttertoast.showToast(msg: '${response.data['message']}');
        }
      } else if (response.statusCode == 302) {
        debugPrint('Redirection: Please check the redirected URL.');
      } else {
        debugPrint('Server error with status code: ${response.statusCode}');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: '$e');
    }
  }

  @override
  void initState() {
    super.initState();
    getCampaignList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Campaign List',
          style: TextStyle(color: Colors.white),
        ),
        leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
              size: 20,
            )),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : campaignListResponse != null
              ? ListView.builder(
                  itemCount: campaignListResponse!.data?.data?.length ?? 0,
                  padding: const EdgeInsets.only(top: 16.0),
                  itemBuilder: (context, index) {
                    var campaign = campaignListResponse!.data!.data![index];
                    return CampaignCarWidget(
                      campaign: campaign,
                      onTap: () {
                        if (campaign.isAssignedAlready == false) {
                          sendJoinRequest(campaign.id ?? 0);
                          setState(() {
                            getCampaignList();
                          });
                        }
                      },
                      joinStatus: campaign.isAssignedAlready == true
                          ? "Approved"
                          : "join",
                    );
                  },
                )
              : const NoDataFoundWidget(),
    );
  }
}
