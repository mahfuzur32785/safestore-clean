import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../controllers/sign_up/sign_up_bloc.dart';

class SignUpForm extends StatefulWidget {
  SignUpForm({Key? key, required this.pageController}) : super(key: key);
  PageController pageController = PageController();
  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  bool _passwordVisible = false;
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SignUpBloc>();
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16,),
            sliver: SliverToBoxAdapter(
              child: Form(
                key: bloc.formKey,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            blurRadius: 6,
                            offset: const Offset(1,1)
                        )
                      ]
                  ),
                  child: Column(
                    children: [
                      AnimatedContainer(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        alignment: Alignment.topLeft,
                        duration: kDuration,
                        child: Center(
                          child: Text("Register",
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Already have an account? ', style: TextStyle(color: Colors.black54),),
                          GestureDetector(
                            onTap: () {
                              widget.pageController.animateToPage(0,duration: kDuration, curve: Curves.bounceInOut);
                            },
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                  color: redColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Divider(color: Colors.grey.shade300),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Row(
                          children: const [
                            Text("Email",style: TextStyle(fontWeight: FontWeight.bold),),
                            Text("*",style: TextStyle(color: Colors.red),),
                          ],
                        ),
                      ),
                      BlocBuilder<SignUpBloc, SignUpModelState>(
                        buildWhen: (previous, current) => previous.email != current.email,
                        builder: (context, state) {
                          return TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            initialValue: state.email,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter email';
                              } else if (!Utils.isEmail(value.trim())) {
                                return "Enter valid email";
                              }
                              return null;
                            },
                            onChanged: (value) => bloc.add(SignUpEventEmail(value)),
                            decoration: InputDecoration(hintText: 'Email'),
                          );
                        },
                      ),
                      const SizedBox(height: 10),

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Row(
                          children: const [
                            Text("Password",style: TextStyle(fontWeight: FontWeight.bold),),
                            Text("*",style: TextStyle(color: Colors.red),),
                          ],
                        ),
                      ),
                      BlocBuilder<SignUpBloc, SignUpModelState>(
                        buildWhen: (previous, current) =>
                        previous.password != current.password,
                        builder: (context, state) {
                          return TextFormField(
                            keyboardType: TextInputType.visiblePassword,
                            initialValue: state.password,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter Password';
                              } else if (value.length < 8) {
                                return 'Password must be 8 character';
                              }
                              return null;
                            },
                            onChanged: (value) => bloc.add(SignUpEventPassword(value)),
                            obscureText: !_passwordVisible,
                            decoration: InputDecoration(
                              hintText: 'Password',
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _passwordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: grayColor,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _passwordVisible = !_passwordVisible;
                                  });
                                },
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Row(
                          children: const [
                            Text("Confirm Password",style: TextStyle(fontWeight: FontWeight.bold),),
                            Text("*",style: TextStyle(color: Colors.red),),
                          ],
                        ),
                      ),
                      BlocBuilder<SignUpBloc, SignUpModelState>(
                        buildWhen: (previous, current) =>
                        previous.passwordConfirmation != current.passwordConfirmation,
                        builder: (context, state) {
                          return TextFormField(
                            keyboardType: TextInputType.visiblePassword,
                            initialValue: state.passwordConfirmation,
                            textInputAction: TextInputAction.done,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter confirm password';
                              } else if (value.length < 8) {
                                return 'Password must be 8 character';
                              } else if (state.password != state.passwordConfirmation) {
                                return "Password doesn't match";
                              }
                              return null;
                            },
                            onChanged: (value) =>
                                bloc.add(SignUpEventPasswordConfirm(value)),
                            obscureText: !_passwordVisible,
                            decoration: InputDecoration(
                              hintText: 'Confirm password',
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _passwordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: grayColor,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _passwordVisible = !_passwordVisible;
                                  });
                                },
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 8),
                      // _buildRememberMe(),
                      const SizedBox(height: 25),
                      BlocBuilder<SignUpBloc, SignUpModelState>(
                        buildWhen: (previous, current) => previous.state != current.state,
                        builder: (context, state) {
                          if (state.state is SignUpStateLoading) {
                            return const Center(child: CircularProgressIndicator());
                          }
                          return SizedBox(
                            height: 48,
                            child: ElevatedButton(
                              onPressed: () {
                                Utils.closeKeyBoard(context);
                                bloc.add(SignUpEventSubmit());
                              },
                              style: ElevatedButton.styleFrom(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.zero),
                                  backgroundColor: redColor,),
                              child: const Text("Register"),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      // const Text(
                      //   'Sign Up With Social',
                      //   style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                      // ),
                      // const SizedBox(height: 12),
                      // const SocialButtons(),
                      // const SizedBox(height: 28),
                      // const GuestButton(),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  // Widget _buildRememberMe() {
  //   return BlocBuilder<SignUpBloc, SignUpModelState>(
  //     buildWhen: (previous, current) => previous.agree != current.agree,
  //     builder: (context, state) {
  //       return CheckboxListTile(
  //         value: state.agree == 1,
  //         dense: true,
  //         contentPadding: EdgeInsets.zero,
  //         checkColor: Colors.white,
  //         activeColor: redColor,
  //         controlAffinity: ListTileControlAffinity.leading,
  //         title: Text(
  //           'I Consent To The Privacy Policy',
  //           style: TextStyle(color: blackColor.withOpacity(.5)),
  //         ),
  //         onChanged: (v) {
  //           if (v == null) return;
  //           context.read<SignUpBloc>().add(SignUpEventAgree(v ? 1 : 0));
  //         },
  //       );
  //     },
  //   );
  // }
}
