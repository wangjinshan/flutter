import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bluetooth Keyboard Test',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      home: const BluetoothKeyboardTestPage(),
    );
  }
}

class BluetoothKeyboardTestPage extends StatefulWidget {
  const BluetoothKeyboardTestPage({super.key});

  @override
  State<BluetoothKeyboardTestPage> createState() => _BluetoothKeyboardTestPageState();
}

class _BluetoothKeyboardTestPageState extends State<BluetoothKeyboardTestPage> {
  final TextEditingController _quillStyleController = TextEditingController();
  final TextEditingController _primitiveController = TextEditingController();
  final ScrollController _quillScrollController = ScrollController();
  final ScrollController _primitiveScrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    // 初始化一些测试文本
    _quillStyleController.text = """这是模拟 Flutter Quill 编辑器的测试区域。

请在这里输入文本来测试蓝牙键盘的软键盘预处理 UI 跟随光标滚动的问题。

你可以：
• 输入长文本
• 使用回车创建新行
• 测试光标位置跟随
• 观察软键盘预处理UI的行为

这里有足够的空间让你测试各种输入场景，包括长段落文本的输入和编辑。当文本超出可视区域时，编辑器应该自动滚动以跟随光标位置。

继续输入更多内容来测试滚动行为...

""";

    _primitiveController.text = """这是 Flutter 原始 TextField 编辑器测试区域。

在这个区域中，你可以测试：
- 基础的文本输入
- 光标跟随行为
- 软键盘预处理UI的滚动问题
- 蓝牙键盘输入的响应

请输入大量文本来测试滚动和光标跟随功能。

""";
  }

  @override
  void dispose() {
    _quillStyleController.dispose();
    _primitiveController.dispose();
    _quillScrollController.dispose();
    _primitiveScrollController.dispose();
    super.dispose();
  }

  Widget _buildQuillStyleEditor() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 工具栏
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.format_bold, size: 20),
                  constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                  padding: EdgeInsets.zero,
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.format_italic, size: 20),
                  constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                  padding: EdgeInsets.zero,
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.format_underlined, size: 20),
                  constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                  padding: EdgeInsets.zero,
                ),
                const VerticalDivider(width: 16, thickness: 1),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.format_list_bulleted, size: 20),
                  constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                  padding: EdgeInsets.zero,
                ),
              ],
            ),
          ),
          // 编辑器
          Expanded(
            child: TextField(
              controller: _quillStyleController,
              scrollController: _quillScrollController,
              maxLines: null,
              expands: true,
              textAlignVertical: TextAlignVertical.top,
              style: const TextStyle(fontSize: 16, height: 1.5),
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(16),
                border: InputBorder.none,
                hintText: '在此输入文本测试...',
              ),
              autofocus: false,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrimitiveEditor() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: _primitiveController,
        scrollController: _primitiveScrollController,
        maxLines: null,
        expands: true,
        textAlignVertical: TextAlignVertical.top,
        style: const TextStyle(fontSize: 16, height: 1.5),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(16),
          border: InputBorder.none,
          hintText: 'Flutter 原始编辑器测试区域...',
        ),
        autofocus: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('蓝牙键盘测试'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          TextButton(
            onPressed: () {
              // 清空文本
              _quillStyleController.clear();
              _primitiveController.clear();
            },
            child: const Text('清空'),
          ),
        ],
      ),
      body: Column(
        children: [
          // 上半部分：模拟 Flutter Quill 编辑器 (50% 高度)
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Flutter Quill 风格编辑器 (50%)',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Expanded(child: _buildQuillStyleEditor()),
                ],
              ),
            ),
          ),

          // 分割线
          Container(height: 2, color: Colors.grey.shade300),

          // 下半部分：Flutter 原始编辑器 (50% 高度)
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Flutter 原始 TextField 编辑器 (50%)',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Expanded(child: _buildPrimitiveEditor()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
