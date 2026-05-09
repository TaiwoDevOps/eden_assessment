import 'package:eden_app/features/auth/presentation/vm/auth_vm.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

final List<SingleChildWidget> providers = [
  ChangeNotifierProvider<AuthProvider>(
    create: (_) => GetIt.I<AuthProvider>(),
  ),
];
