import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addToFavorites(String productName, String productCode) async {
    try {
      await _firestore.collection('favorites').doc().set({
        'name': productName,
        'code': productCode,
        'timestamp':
            FieldValue.serverTimestamp(), // Adicione um timestamp opcional
      });
    } catch (e) {
      print('Erro ao adicionar favorito: $e');
    }
  }

  Future<void> removeFromFavorites(
      String productName, String productCode) async {
    try {
      await _firestore.collection('favorites').doc().delete();
    } catch (e) {
      print('Erro ao remover favorito: $e');
    }
  }

  Future<List<String>> getFavoriteProducts() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firestore.collection('favorites').get();

      List<String> favorites =
          querySnapshot.docs.map((doc) => doc['code'] as String).toList();

      return favorites;
    } catch (e) {
      print('Erro ao obter produtos favoritos: $e');
      return [];
    }
  }
}
