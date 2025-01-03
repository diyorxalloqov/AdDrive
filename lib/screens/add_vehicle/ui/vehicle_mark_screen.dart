/*
 *  (c) Diyor Xalloqov 2024.8.15 Toshkent, Uzbekistan
 *  github: https://github.com/diyorxalloqov
 *  LinkedIn: https://www.linkedin.com/in/diyor-xalloqov-024b63231/
 *  Telegram: https://t.me/Flutter_dart_developer
 */

import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:addrive/global/imports/app_imports.dart';
import 'package:addrive/global/widgets/text_form_field_widget_2.dart';
import 'package:addrive/screens/add_vehicle/bloc/car_bloc.dart';
import 'package:addrive/screens/add_vehicle/model/car_details_model.dart';
import 'package:addrive/screens/add_vehicle/ui/choice_vehicle_year.dart';
import 'package:addrive/utils/enums/status.dart';

class AddVehicleMarkScreenMain extends StatefulWidget {
  const AddVehicleMarkScreenMain({super.key});

  @override
  State<AddVehicleMarkScreenMain> createState() => _AddVehicleScreenMainState();
}

class _AddVehicleScreenMainState extends State<AddVehicleMarkScreenMain> {
  @override
  void initState() {
    context.read<CarBloc>().add(GetCarsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWidget(centerTitle: true, titleText: 'choice_model'.tr),
        body: BlocBuilder<CarBloc, CarState>(
          builder: (context, state) {
            if (state.carDetailsStatus == ActionStatus.isLoading) {
              return const Center(child: Loading());
            } else if (state.carDetailsStatus == ActionStatus.isSuccess) {
              return AddVehicleScreen(cars: state.carDetailsModel);
            } else if (state.carDetailsStatus == ActionStatus.isError) {
              return Center(
                  child: Text(state.carsDetailsError,
                      style: context.theme.textTheme.labelMedium));
            } else {
              return const SizedBox.shrink();
            }
          },
        ));
  }
}

class AddVehicleScreen extends StatefulWidget {
  final List<CarDetailsModel> cars;

  const AddVehicleScreen({super.key, required this.cars});

  @override
  State<AddVehicleScreen> createState() => _AddVehicleScreenState();
}

class _AddVehicleScreenState extends State<AddVehicleScreen> {
  String? selectedMark;
  List<CarDetailsModel> filteredMarks = [];
  late TextEditingController _searchController;
  int indexs = 0;

  @override
  void initState() {
    filteredMarks = widget.cars;
    _searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterMarks(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredMarks = widget.cars;
      } else {
        filteredMarks = widget.cars
            .where((mark) =>
                mark.id?.toLowerCase().contains(query.toLowerCase()) ?? false)
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('choice_car_model'.tr,
              style: context.theme.textTheme.bodyLarge?.copyWith(fontSize: 20)),
          const SpaceHeight(height: 16),
          TextFormFieldWidget2(
              prefix: Icon(Icons.search,
                  color: context.theme.colorScheme.onPrimary, size: 20),
              controller: _searchController,
              onChanged: _filterMarks,
              hintText: 'search'.tr),
          const SpaceHeight(height: 20),
          Text('popular'.tr, style: context.theme.textTheme.displayMedium),
          const SpaceHeight(height: 20),
          Expanded(
            child: filteredMarks.isEmpty
                ? SingleChildScrollView(
                    child: SizedBox(
                      height: 300,
                      child: Center(
                        child: Text('no_car'.tr,
                            style: context.theme.textTheme.labelMedium),
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: filteredMarks.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          ListTile(
                              onTap: () {
                                setState(() {
                                  selectedMark = filteredMarks[index].id;
                                  indexs = index;
                                });
                              },
                              leading: const CircleAvatar(
                                backgroundImage: NetworkImage(
                                    'https://upload.wikimedia.org/wikipedia/commons/thumb/4/44/BMW.svg/768px-BMW.svg.png'),
                              ),
                              title: Text(filteredMarks[index].name ?? '',
                                  style: context.theme.textTheme.labelMedium),
                              trailing: selectedMark == filteredMarks[index].id
                                  ? Icon(Icons.check,
                                      color:
                                          context.theme.colorScheme.onPrimary)
                                  : null,
                              splashColor: Colors.transparent,
                              contentPadding: const EdgeInsets.only(right: 10)),
                          Divider(
                              color: context.theme.colorScheme.onPrimary
                                  .withOpacity(0.1))
                        ],
                      );
                    },
                  ),
          ),
          CustomButton(
              onPressed: (selectedMark != null && filteredMarks.isNotEmpty)
                  ? () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChoiceVehicleYear(
                                  carDetailsModel: filteredMarks[indexs])));
                    }
                  : null,
              title: 'confirm'.tr,
              padding: EdgeInsets.zero),
          const SpaceHeight(height: 20)
        ],
      ),
    );
  }
}
