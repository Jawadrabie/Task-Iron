import 'package:flutter/material.dart';
import '../controllers/steel_viewer_controller.dart';
import '../widgets/steel_loading_widget.dart';
import '../widgets/steel_error_widget.dart';
import '../widgets/steel_viewer_body.dart';
import '../core/constants/app_constants.dart';

class SteelViewerScreen extends StatefulWidget {
  const SteelViewerScreen({super.key});

  @override
  State<SteelViewerScreen> createState() => _SteelViewerScreenState();
}

class _SteelViewerScreenState extends State<SteelViewerScreen> {
  late final SteelViewerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = SteelViewerController();
    _controller.loadData();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(AppColors.background),
      appBar: AppBar(
        title: Text(
          _controller.steelData?.labelAr ?? 'مقاطع الحديد',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
        elevation: 2,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return ListenableBuilder(
      listenable: _controller,
      builder: (context, child) {
        if (_controller.isLoading) {
          return const SteelLoadingWidget();
        }

        if (_controller.errorMessage != null) {
          return SteelErrorWidget(
            errorMessage: _controller.errorMessage!,
            onRetry: _controller.loadData,
          );
        }

        return SteelViewerBody(controller: _controller);
      },
    );
  }
}
