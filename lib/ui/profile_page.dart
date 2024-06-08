import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kopma/bloc/user_bloc/user_bloc.dart';
import 'package:kopma/data/model/user/user_model.dart';
import 'package:kopma/data/user_repository.dart';
import 'package:kopma/ui/component/text_field.dart';

class ProfilePage extends StatefulWidget {
  final UserRepository userRepository;

  const ProfilePage({super.key, required this.userRepository});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final addressController = TextEditingController();
  UserModel user = UserModel.empty;

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {},
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          user = state.user ?? UserModel.empty;
          return ProfileScreen(
            providers: const [],
            actions: [
              SignedOutAction((context) {
                Navigator.pushReplacementNamed(context, '/sign-in');
              }),
              AccountDeletedAction((context, user) {
                Navigator.pushReplacementNamed(context, '/sign-in');
              })
            ],
            children: [
              Card(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Spacer(
                      flex: 1,
                    ),
                    const Icon(Icons.account_balance_wallet),
                    Text((state.user?.balance ?? 0).toString()),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const Padding(padding: EdgeInsets.all(4.0)),
                        IconButton(
                          icon: const Icon(Icons.add_box),
                          tooltip: 'Top Up',
                          onPressed: () {
                            context.read<UserBloc>().add(SetUserData(
                                user: user.copyWith(
                                    balance: (user.balance ?? 0) + 10000)));
                          },
                        ),
                        const Text('Top up'),
                        const Padding(padding: EdgeInsets.all(4.0)),
                      ],
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                  ],
                ),
              ),
              MyTextField(
                controller: addressController,
                hintText: 'Address',
                obscureText: false,
                keyboardType: TextInputType.streetAddress,
                prefixIcon: const Icon(Icons.location_city),
                textInputAction: TextInputAction.done,
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Please fill in this field';
                  }
                  return null;
                },
              ),
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    context.read<UserBloc>().add(SetUserData(
                        user: user.copyWith(address: addressController.text)));
                  });
                },
                icon: const Icon(Icons.save),
                label: const Text("Save"),
              )
            ],
          );
        },
      ),
    );
  }
}
