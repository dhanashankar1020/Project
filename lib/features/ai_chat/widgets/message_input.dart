import 'package:flutter/material.dart';

class MessageInput extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onSend;
  final bool isLoading;

  const MessageInput({
    super.key,
    required this.controller,
    required this.onSend,
    this.isLoading = false,
  });

  @override
  State<MessageInput> createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasText = widget.controller.text.trim().isNotEmpty;

    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          border: Border(
            top: BorderSide(
              color: theme.colorScheme.outline.withValues(alpha: .15),
            ),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            /// Future Voice Button
            IconButton(
              onPressed: widget.isLoading ? null : () {},
              icon: const Icon(Icons.mic_none_rounded),
              tooltip: "Voice (Coming Soon)",
            ),

            Expanded(
              child: TextField(
                controller: widget.controller,
                onChanged: (_) => setState(() {}),
                enabled: !widget.isLoading,
                minLines: 1,
                maxLines: 5,
                textInputAction: TextInputAction.send,
                onSubmitted: (_) {
                  if (!widget.isLoading && hasText) {
                    widget.onSend();
                  }
                },
                decoration: InputDecoration(
                  hintText: "Ask SafePlace AI...",
                  filled: true,
                  fillColor: theme.colorScheme.surfaceContainerHighest
                      .withValues(alpha: .5),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 14,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(28),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            const SizedBox(width: 10),

            AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              child: widget.isLoading
                  ? Padding(
                      key: const ValueKey("loading"),
                      padding: const EdgeInsets.all(12),
                      child: SizedBox(
                        height: 22,
                        width: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    )
                  : FloatingActionButton.small(
                      key: const ValueKey("send"),
                      elevation: 0,
                      heroTag: null,
                      onPressed: hasText && !widget.isLoading
                          ? widget.onSend
                          : null,
                      child: const Icon(Icons.send_rounded),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
