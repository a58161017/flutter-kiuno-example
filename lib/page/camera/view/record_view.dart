part of '../frame/action_frame.dart';

class RecordView extends StatefulWidget {
  final bool isRecording;

  RecordView({required this.isRecording});

  @override
  _RecordViewState createState() => _RecordViewState();
}

class _RecordViewState extends State<RecordView> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: widget.isRecording ? 80 : 64,
      height: widget.isRecording ? 80 : 64,
      decoration: BoxDecoration(
        color: Color(0x99C3D5DC),
        shape: BoxShape.circle,
      ),
      duration: const Duration(milliseconds: 300),
      child: Center(
        child: AnimatedContainer(
          width: widget.isRecording ? 28 : 56,
          height: widget.isRecording ? 28 : 56,
          decoration: BoxDecoration(
            color: Color(0xFFFAFDFF),
            borderRadius: BorderRadius.circular(widget.isRecording ? 6 : 64),
          ),
          duration: const Duration(milliseconds: 300),
        ),
      ),
    );
  }
}
