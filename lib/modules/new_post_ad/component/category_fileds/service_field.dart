import 'package:safestore/modules/home/model/service_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controller/new_posted_bloc.dart';

class ServiceField extends StatefulWidget {
  const ServiceField({Key? key}) : super(key: key);
  @override
  State<ServiceField> createState() => _ServiceFieldState();
}

class _ServiceFieldState extends State<ServiceField> {

  @override
  Widget build(BuildContext context) {
    final postAdBloc = context.read<NewPostAdBloc>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 16,
        ),
        Text("Service type",style: const TextStyle(fontSize: 16),),
        const SizedBox(
          height: 7,
        ),
        BlocBuilder<NewPostAdBloc, NewPostAdModalState>(
          builder: (context, state) {
            return DropdownButtonFormField(
              // validator: (value) {
              //   if (value == null) {
              //     return null;
              //   }
              //   return null;
              // },
              isExpanded: true,
              decoration: const InputDecoration(
                hintText: "Select Service Type"
              ),
              items: postAdBloc.serviceTypeList.map<DropdownMenuItem<ServiceTypeModel>>((e) {
                return DropdownMenuItem(
                  value: e,
                  child: Text(e.title),
                );
              }).toList(),
              onChanged: (value) {
                print(value);
                Future.delayed(const Duration(milliseconds: 300)).then((value2) {
                  postAdBloc.add(NewPostAdEventServiceTypeId(value!.id.toString(), value));
                });
              },
            );
          },
        ),

      ],
    );
  }
}
