import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RecordView extends StatefulWidget {
  final bool isRecording;
  final double progress;
  final double max;

  RecordView(
      {required this.isRecording, required this.progress, required this.max});

  @override
  _RecordViewState createState() => _RecordViewState();
}

class _RecordViewState extends State<RecordView> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 92,
      height: 92,
      child: Stack(
        children: [
          Visibility(
            visible: widget.isRecording,
            child: SizedBox(
              width: 92,
              height: 92,
              child: CircularProgressIndicator(
                color: Color(0xFFFFB47D),
                strokeWidth: 5,
                value: widget.progress / widget.max,
              ),
            ),
          ),
          Align(
            child: AnimatedContainer(
              width: widget.isRecording ? 80 : 64,
              height: widget.isRecording ? 80 : 64,
              decoration: BoxDecoration(
                color: Color(0x99C3D5DC),
                shape: BoxShape.circle,
              ),
              curve: Curves.decelerate,
              duration: const Duration(milliseconds: 300),
              child: Center(
                child: AnimatedContainer(
                  width: widget.isRecording ? 28 : 56,
                  height: widget.isRecording ? 28 : 56,
                  decoration: BoxDecoration(
                    color: Color(0xFFFAFDFF),
                    borderRadius:
                        BorderRadius.circular(widget.isRecording ? 6 : 64),
                  ),
                  curve: Curves.decelerate,
                  duration: const Duration(milliseconds: 300),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
