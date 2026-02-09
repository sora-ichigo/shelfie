import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/core/widgets/app_snack_bar.dart';
import 'package:shelfie/features/book_search/domain/isbn_extractor.dart';

/// ISBN スキャン画面
///
/// カメラを使用して書籍のバーコード（EAN-13/ISBN-13）をスキャンし、
/// ISBN を抽出する画面。
class ISBNScanScreen extends ConsumerStatefulWidget {
  const ISBNScanScreen({
    super.key,
    this.testCameraPermissionDenied = false,
  });

  /// テスト用: カメラ権限拒否状態をシミュレート
  final bool testCameraPermissionDenied;

  @override
  ConsumerState<ISBNScanScreen> createState() => _ISBNScanScreenState();
}

class _ISBNScanScreenState extends ConsumerState<ISBNScanScreen> {
  MobileScannerController? _controller;
  bool _isScanning = true;
  bool _cameraPermissionDenied = false;
  bool _cameraError = false;
  String? _lastScannedISBN;

  @override
  void initState() {
    super.initState();
    if (widget.testCameraPermissionDenied) {
      _cameraPermissionDenied = true;
    } else {
      _initializeCamera();
    }
  }

  void _initializeCamera() {
    _controller = MobileScannerController(
      detectionSpeed: DetectionSpeed.normal,
      facing: CameraFacing.back,
      formats: [BarcodeFormat.ean13, BarcodeFormat.ean8],
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColors>()!;

    if (_cameraPermissionDenied) {
      return _buildPermissionDeniedView(theme, appColors);
    }

    return Scaffold(
      backgroundColor: appColors.overlay,
      body: Stack(
        children: [
          if (_controller case final controller?)
            MobileScanner(
              controller: controller,
              onDetect: _onBarcodeDetected,
              errorBuilder: (context, error) {
                if (error.errorCode == MobileScannerErrorCode.permissionDenied) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (mounted) {
                      setState(() {
                        _cameraPermissionDenied = true;
                      });
                    }
                  });
                }
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (mounted && !_cameraError) {
                    setState(() {
                      _cameraError = true;
                    });
                  }
                });
                return Center(
                  child: Text(
                    'カメラの初期化に失敗しました',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: appColors.textPrimary,
                    ),
                  ),
                );
              },
            ),
          if (!_cameraError) ...[
            _buildScanOverlay(theme, appColors),
            _buildInstructionText(theme, appColors),
          ],
          _buildTopBar(theme, appColors),
          if (_cameraError && kDebugMode) _buildDebugISBNInput(theme),
        ],
      ),
    );
  }

  Widget _buildPermissionDeniedView(ThemeData theme, AppColors appColors) {
    return Scaffold(
      backgroundColor: appColors.overlay,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.close, color: appColors.textPrimary),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center(
        child: Padding(
          padding: AppSpacing.all(AppSpacing.lg),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.camera_alt_outlined,
                size: 64,
                color: appColors.textPrimary.withOpacity(0.54),
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                'カメラへのアクセスが拒否されています',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: appColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                '本のバーコードをスキャンするには、設定からカメラへのアクセスを許可してください。',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: appColors.textPrimary.withOpacity(0.7),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.xl),
              FilledButton.icon(
                onPressed: _openAppSettings,
                icon: const Icon(Icons.settings),
                label: const Text('設定を開く'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(ThemeData theme, AppColors appColors) {
    return SafeArea(
      child: Padding(
        padding: AppSpacing.all(AppSpacing.md),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.close, color: appColors.textPrimary),
              onPressed: () => Navigator.of(context).pop(),
            ),
            if (_controller != null)
              IconButton(
                icon: Icon(
                  Icons.flash_off,
                  color: appColors.textPrimary,
                ),
                onPressed: () => _controller?.toggleTorch(),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildScanOverlay(ThemeData theme, AppColors appColors) {
    return Container(
      key: const Key('scan_overlay'),
      child: CustomPaint(
        painter: _ScanOverlayPainter(
          borderColor: appColors.primary,
          overlayColor: appColors.overlay,
        ),
        child: const SizedBox.expand(),
      ),
    );
  }

  Widget _buildInstructionText(ThemeData theme, AppColors appColors) {
    return Positioned(
      bottom: 100,
      left: 0,
      right: 0,
      child: Text(
        'バーコードを枠内に合わせてください',
        style: theme.textTheme.bodyLarge?.copyWith(
          color: appColors.textPrimary,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildDebugISBNInput(ThemeData theme) {
    return Positioned(
      right: AppSpacing.md,
      bottom: AppSpacing.xl,
      child: FloatingActionButton.small(
        onPressed: () async {
          final controller = TextEditingController(text: '9784798158167');
          final isbn = await showDialog<String>(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('ISBN を入力'),
              content: TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                autofocus: true,
                decoration: const InputDecoration(hintText: '978...'),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('キャンセル'),
                ),
                FilledButton(
                  onPressed: () {
                    final isbn = ISBNExtractor.extractISBN(controller.text);
                    Navigator.of(context).pop(isbn);
                  },
                  child: const Text('決定'),
                ),
              ],
            ),
          );
          if (isbn != null && mounted) {
            Navigator.of(context).pop(isbn);
          }
        },
        child: const Icon(Icons.edit, size: 18),
      ),
    );
  }

  void _onBarcodeDetected(BarcodeCapture capture) {
    if (!_isScanning) return;

    for (final barcode in capture.barcodes) {
      final rawValue = barcode.rawValue;
      if (rawValue == null) continue;

      final isbn = ISBNExtractor.extractISBN(rawValue);
      if (isbn != null && isbn != _lastScannedISBN) {
        _lastScannedISBN = isbn;
        _isScanning = false;
        _controller?.stop();
        Navigator.of(context).pop(isbn);
        return;
      }
    }
  }

  Future<void> _openAppSettings() async {
    // 設定アプリを開く（プラットフォーム固有の実装が必要）
    // 現時点では、ユーザーに手動で設定を開くよう促す
    if (mounted) {
      AppSnackBar.show(
        context,
        message: '設定アプリからカメラへのアクセスを許可してください',
        type: AppSnackBarType.info,
      );
    }
  }
}

/// スキャンオーバーレイのカスタムペインター
class _ScanOverlayPainter extends CustomPainter {
  _ScanOverlayPainter({required this.borderColor, required this.overlayColor});

  final Color borderColor;
  final Color overlayColor;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    const scanAreaWidth = 280.0;
    const scanAreaHeight = 150.0;

    final scanRect = Rect.fromCenter(
      center: center,
      width: scanAreaWidth,
      height: scanAreaHeight,
    );

    final backgroundPaint = Paint()
      ..color = overlayColor.withOpacity(0.6);

    // スキャン領域以外を塗りつぶす
    final path = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height))
      ..addRRect(
        RRect.fromRectAndRadius(scanRect, const Radius.circular(12)),
      )
      ..fillType = PathFillType.evenOdd;

    canvas.drawPath(path, backgroundPaint);

    // スキャン領域の枠線
    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    canvas.drawRRect(
      RRect.fromRectAndRadius(scanRect, const Radius.circular(12)),
      borderPaint,
    );

    // コーナーのアクセント
    const cornerLength = 30.0;
    const cornerOffset = 6.0;
    final cornerPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    // 左上
    canvas
      ..drawLine(
        Offset(scanRect.left - cornerOffset, scanRect.top + 12),
        Offset(scanRect.left - cornerOffset, scanRect.top - cornerOffset),
        cornerPaint,
      )
      ..drawLine(
        Offset(scanRect.left - cornerOffset, scanRect.top - cornerOffset),
        Offset(scanRect.left + cornerLength, scanRect.top - cornerOffset),
        cornerPaint,
      )

      // 右上
      ..drawLine(
        Offset(scanRect.right - cornerLength, scanRect.top - cornerOffset),
        Offset(scanRect.right + cornerOffset, scanRect.top - cornerOffset),
        cornerPaint,
      )
      ..drawLine(
        Offset(scanRect.right + cornerOffset, scanRect.top - cornerOffset),
        Offset(scanRect.right + cornerOffset, scanRect.top + cornerLength),
        cornerPaint,
      )

      // 左下
      ..drawLine(
        Offset(scanRect.left - cornerOffset, scanRect.bottom - cornerLength),
        Offset(scanRect.left - cornerOffset, scanRect.bottom + cornerOffset),
        cornerPaint,
      )
      ..drawLine(
        Offset(scanRect.left - cornerOffset, scanRect.bottom + cornerOffset),
        Offset(scanRect.left + cornerLength, scanRect.bottom + cornerOffset),
        cornerPaint,
      )

      // 右下
      ..drawLine(
        Offset(scanRect.right - cornerLength, scanRect.bottom + cornerOffset),
        Offset(scanRect.right + cornerOffset, scanRect.bottom + cornerOffset),
        cornerPaint,
      )
      ..drawLine(
        Offset(scanRect.right + cornerOffset, scanRect.bottom + cornerOffset),
        Offset(scanRect.right + cornerOffset, scanRect.bottom - cornerLength),
        cornerPaint,
      );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
