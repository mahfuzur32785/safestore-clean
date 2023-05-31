import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safestore/utils/constants.dart';
import 'package:safestore/utils/utils.dart';

import '../../controller/edit_profile/ads_edit_profile_cubit.dart';

class DeleteAccount extends StatefulWidget {
  const DeleteAccount({Key? key}) : super(key: key);

  @override
  State<DeleteAccount> createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AdEditProfileCubit>();
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.transparent),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 6,
                  offset: const Offset(0, 5))
            ]),
        child: Column(
          children: [
            Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 0),
                  child: Text(
                    "Deactivate Account",
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                )),
            Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    "By clicking below button your account will be deleted permanently. You won't able to retrieve your account anymore.",
                    textAlign: TextAlign.left,
                    style: const TextStyle(color: Colors.black45),
                  ),
                )),
            const SizedBox(
              height: 24,
            ),
            SizedBox(
              height: 48,
              child: BlocBuilder<AdEditProfileCubit, EditProfileState>(
                  builder: (context, state) {
                if (state is EditProfileStateDeleteLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red,
                      shadowColor: ashColor,
                      side: const BorderSide(
                          color: Colors.red,
                          strokeAlign: BorderSide.strokeAlignInside),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4))),
                  onPressed: () {
                    Utils.showCustomDialog(context,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          height: 300,
                          width: double.infinity,
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Type 'delete' to delete your account.",
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              SizedBox(height: 5),
                              const Center(
                                child: Text(
                                  "All contacts and other data associated with this account will be permanently deleted. This cannot be undone.",
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                validator: (value) {
                                  if (value != null || value!.isNotEmpty) {
                                    setState(() {
                                      bloc.deleteController.text = value.toString();
                                    });
                                  }
                                  return 'this filed is required';
                                },
                                controller: bloc.deleteController,
                                decoration: InputDecoration(
                                  hintText: "Type 'delete' to delete your account.",
                                  hintStyle: TextStyle(fontSize: 12)
                                ),
                              ),
                              const Spacer(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    style: TextButton.styleFrom(
                                        foregroundColor: redColor),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("Cancel"),
                                  ),
                                  TextButton(
                                    style: TextButton.styleFrom(
                                        foregroundColor: redColor),
                                    onPressed: () {
                                      if(bloc.deleteController.text.isNotEmpty){
                                        Navigator.pop(context);
                                        bloc.deleteAccount(bloc.deleteController.text.trim());
                                      }else{
                                        Utils.errorSnackBar(context, 'this feild is required');
                                        print('this filed is required');
                                      }
                                    },
                                    child: Text("Ok"),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        barrierDismissible: true);
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  label: Text(
                    "Delete account",
                    style: const TextStyle(
                        color: Colors.red, fontWeight: FontWeight.w400),
                  ),
                );
              }),
            )
          ],
        ));
  }
}
