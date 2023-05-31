import 'package:safestore/modules/home/model/service_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controller/new_ad_edit_bloc.dart';

class EditService extends StatefulWidget {
  const EditService({Key? key}) : super(key: key);

  @override
  State<EditService> createState() => _EditServiceState();
}

class _EditServiceState extends State<EditService> {

  ServiceTypeModel? serviceTypeModel;

  @override
  Widget build(BuildContext context) {
    final postAdBloc = context.read<NewEditAdBloc>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Service type",style: const TextStyle(fontSize: 16),),
        const SizedBox(
          height: 7,
        ),
        BlocBuilder<NewEditAdBloc, NewEditAdModalState>(
            buildWhen: (previous, current) => previous.adsId != current.adsId,
            builder: (context, state) {
              return DropdownButtonFormField<ServiceTypeModel>(
                isExpanded: true,
                decoration: const InputDecoration(
                  hintText: "Select Service Type",
                ),
                value: postAdBloc.serviceTypeModel,
                items: postAdBloc.serviceTypeList.map<DropdownMenuItem<ServiceTypeModel>>((e) {
                  return DropdownMenuItem<ServiceTypeModel>(
                    value: e,
                    child: Text(e.title),
                  );
                }).toList(),
                onChanged: (ServiceTypeModel? value) {
                  setState(() {
                    serviceTypeModel = null;
                  });
                  postAdBloc.add(NewEditAdEventServiceTypeId(value!.id.toString(),value));
                },
              );
            }
        ),

        const SizedBox(
          height: 16,
        ),
      ],
    );
  }
}
