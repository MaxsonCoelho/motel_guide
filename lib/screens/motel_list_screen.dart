import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/motel_provider.dart';
import '../widgets/motel_item.dart';
import '../widgets/motel_shimmer.dart';

class MotelListScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final motelState = ref.watch(motelProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Motéis')),
      body: RefreshIndicator(
        onRefresh: () async => ref.read(motelProvider.notifier).fetchMotels(),
        child: motelState.when(
          loading: () => MotelShimmer(),
          error: (err, _) => Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Erro ao carregar os dados', 
                      style: TextStyle(color: Colors.red, fontSize: 16)),
                  SizedBox(height: 10),
                  Text(err.toString(), textAlign: TextAlign.center, 
                      style: TextStyle(color: Colors.black54)),
                ],
              ),
            ),
          ),
          data: (motels) => motels.isEmpty
              ? Center(child: Text("Nenhum motel encontrado."))
              : ListView.builder(
                  itemCount: motels.length,
                  itemBuilder: (ctx, i) => MotelItem(motels[i]),
                ),
        ),
      ),
    );
  }
}
