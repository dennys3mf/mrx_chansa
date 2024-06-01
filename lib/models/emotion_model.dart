import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EmotionModel extends ChangeNotifier {
  final String userId;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String _currentEmotion = 'Feliz';

  EmotionModel(this.userId) {
    _loadEmotion();
  }

  String get currentEmotion => _currentEmotion;

  void setEmotion(String emotion) async {
    _currentEmotion = emotion;
    notifyListeners();
    await _saveEmotion();
  }

  Future<void> _loadEmotion() async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection('users').doc(userId).get();
      if (doc.exists) {
        _currentEmotion = doc['emotion'];
        notifyListeners();
      }
    } catch (e) {
      print('Error al cargar la emoción: $e');
    }
  }

  Future<void> _saveEmotion() async {
    try {
      await _firestore.collection('users').doc(userId).set({
        'emotion': _currentEmotion,
      });
    } catch (e) {
      print('Error al guardar la emoción: $e');
    }
  }
}
