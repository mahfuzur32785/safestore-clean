import 'package:safestore/core/remote_urls.dart';
import 'package:safestore/modules/chat/controller/message_cubit/message_cubit.dart';
import 'package:safestore/utils/utils.dart';
import 'package:safestore/widgets/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../utils/constants.dart';
import '../../utils/k_images.dart';

class ChatDetailsScreen extends StatefulWidget {
  const ChatDetailsScreen({Key? key, required this.username}) : super(key: key);
  final String username;

  @override
  State<ChatDetailsScreen> createState() => _ChatDetailsScreenState();
}

class _ChatDetailsScreenState extends State<ChatDetailsScreen> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<MessageCubit>().getUserMessage(true, widget.username));
    WidgetsBinding.instance.addPostFrameCallback((_) => scrollController.position.maxScrollExtent);
  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    final messageBloc = context.read<MessageCubit>();
    return Scaffold(
      backgroundColor: ashColor,
      body: SafeArea(
        child:
            BlocBuilder<MessageCubit, MessageState>(builder: (context, state) {
          if (state is MessageStateLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is MessageStateError) {
            return Center(
              child: Text(
                state.errorMsg,
                style: const TextStyle(color: redColor),
              ),
            );
          }
          return RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: () => context.read<MessageCubit>().getUserMessage(false, widget.username),
            child: Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 6,
                        offset: const Offset(0, 5))
                  ]),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              "Chat with ${messageBloc.chatModel?.selectedUser?.name}"),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: const Icon(Icons.close),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          const SizedBox(
                            height: 8,
                          ),
                          IntrinsicHeight(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                CustomImage(
                                  path:
                                      "${RemoteUrls.rootUrl3}${messageBloc.chatModel?.selectedUser?.image}",
                                  width: 80,
                                  height: 60,
                                  fit: BoxFit.cover,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Visibility(
                                        visible: messageBloc.chatModel?.selectedUser?.name.toString() != '',
                                        child: Text(
                                          "${messageBloc.chatModel?.selectedUser?.name}",
                                          style: const TextStyle(
                                              color: Colors.black87,
                                              fontSize: 14),
                                        ),
                                      ),
                                      Visibility(
                                        visible: messageBloc.chatModel?.selectedUser?.address.toString() != '',
                                        child: Text(
                                          "${messageBloc.chatModel?.selectedUser?.address}",
                                          style: const TextStyle(
                                              color: Colors.black54,
                                              fontSize: 13),
                                        ),
                                      ),
                                      Visibility(
                                          visible: messageBloc.chatModel?.selectedUser?.showEmail != 1 && messageBloc.chatModel?.selectedUser?.email.toString() !='',
                                          child: Text(
                                            "${messageBloc.chatModel?.selectedUser?.email}",
                                            style: const TextStyle(
                                                color: Colors.black54,
                                                fontSize: 13),
                                          )),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                messageBloc.messageList.length == 0
                    ? Expanded(
                        child: SizedBox(
                        height: 150,
                        width: double.infinity,
                        child: Center(
                          child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(color: Colors.black54)),
                              child: Text(
                                "No chat found",
                                style: const TextStyle(
                                    color: Colors.black54,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              )),
                        ),
                      ))
                    : Expanded(
                        child: SingleChildScrollView(
                          controller: scrollController,
                          reverse: true,
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: ListView.separated(
                            shrinkWrap: true,
                            reverse: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: messageBloc.messageList.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 3),
                                child: Row(
                                  mainAxisAlignment: messageBloc.isMe(
                                          messageBloc.messageList[index].fromId)
                                      ? MainAxisAlignment.end
                                      : MainAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment: messageBloc.isMe(
                                              messageBloc
                                                  .messageList[index].fromId)
                                          ? CrossAxisAlignment.end
                                          : CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 6),
                                          decoration: BoxDecoration(
                                              color: messageBloc.isMe(
                                                      messageBloc
                                                          .messageList[index]
                                                          .fromId)
                                                  ? Colors.blue
                                                  : Colors.white,
                                              borderRadius: BorderRadius.only(
                                                topLeft:
                                                    const Radius.circular(6),
                                                topRight:
                                                    const Radius.circular(6),
                                                bottomRight: index % 2 == 0
                                                    ? Radius.circular(0)
                                                    : Radius.circular(6),
                                                bottomLeft: Radius.circular(0),
                                              )),
                                          child: Text(
                                            messageBloc.messageList[index].body,
                                            style: TextStyle(
                                                color: messageBloc.isMe(
                                                        messageBloc
                                                            .messageList[index]
                                                            .fromId)
                                                    ? Colors.white
                                                    : Colors.black87,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              Utils.timeAgo(messageBloc
                                                  .messageList[index]
                                                  .createdAt),
                                              style: TextStyle(
                                                  color: Colors.black38,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            const SizedBox(
                                              width: 3,
                                            ),
                                            CustomImage(
                                              path: Kimages.doubleCheck,
                                              height: 16,
                                              width: 16,
                                              color: messageBloc
                                                          .messageList[index]
                                                          .read ==
                                                      1
                                                  ? Colors.blue
                                                  : ashTextColor,
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                height: 8,
                              );
                            },
                          ),
                        ),
                      ),
                Container(
                  height: 60,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(color: ashColor, boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 3,
                        offset: const Offset(0, -5))
                  ]),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: messageBloc.messageController,
                          textInputAction: TextInputAction.send,
                          onFieldSubmitted: (value) {
                            if (value != '') {
                              messageBloc.sendMessage(value, widget.username);
                            }
                          },
                          decoration: InputDecoration(
                            hintText:
                                "Type your message",
                            hintStyle: const TextStyle(fontSize: 14),
                            fillColor: Colors.white,
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(
                                    color: Colors.transparent)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(
                                    color: Colors.transparent)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(
                                    color: Colors.transparent)),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(
                                    color: Colors.transparent)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (messageBloc.messageController.text == '') {
                            return Utils.showSnackBarWithAction(context,
                                "Type your message",
                                () {
                              ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar();
                            },
                                actionText:
                                    "Cancel");
                          }
                          messageBloc.sendMessage(
                              messageBloc.messageController.text,
                              widget.username);
                        },
                        child: BlocBuilder<MessageCubit, MessageState>(
                            builder: (context, state) {
                          if (state is MessageStateSendLoading) {
                            return const Center(
                                child: SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator()));
                          }
                          return const Icon(
                            Icons.send,
                            color: redColor,
                          );
                        }),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
