import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import '../models/emotion_model.dart';

class EmotionScreen extends StatelessWidget {
  final List<String> emotions = [
    'Feliz',
    'Triste',
    'Enojado',
    'Sorprendido',
    'Relajado'
  ];

final List<String> motivationalQuotes = [
    'El éxito es la suma de pequeños esfuerzos repetidos día tras día.',
    'El único lugar donde el éxito viene antes que el trabajo es en el diccionario.',
    'La vida es un 10% lo que me ocurre y un 90% cómo reacciono a ello.',
    'El optimismo es la fe que conduce al éxito.',
    'La única manera de hacer un gran trabajo es amar lo que haces.',
    'El fracaso es solo la oportunidad de comenzar de nuevo de manera más inteligente.',
    'El éxito no es la clave de la felicidad. La felicidad es la clave del éxito.',
    'No cuentes los días, haz que los días cuenten.',
    'El éxito suele llegar a los que están demasiado ocupados para buscarlo.',
    'No esperes. El tiempo nunca será el adecuado.',
    'El éxito no es el final, el fracaso no es fatal: es el coraje para continuar lo que cuenta.',
    'No es el más fuerte de las especies el que sobrevive, ni el más inteligente; es aquel que es más adaptable al cambio.',
    'La única limitación para nuestra realización del mañana serán nuestras dudas de hoy.',
    'Lo que haces hoy puede mejorar todos tus mañanas.',
    'El futuro pertenece a quienes creen en la belleza de sus sueños.',
    'El éxito es la capacidad de ir de fracaso en fracaso sin perder el entusiasmo.',
    'La acción es la clave fundamental para todo éxito.',
    'El éxito no consiste en no equivocarse nunca, sino en no cometer el mismo error dos veces.',
    'El éxito es la suma de pequeños esfuerzos, repetidos día tras día.',
    'El éxito es la realización progresiva de un propósito valioso.',
    'El éxito es hacer lo que quieres hacer, cuando quieres, donde quieres, con quien quieres y tanto como quieras.',
    'El éxito es conseguir lo que quieres. La felicidad es querer lo que consigues.',
    'El éxito es la habilidad de ir de un fracaso a otro sin perder el entusiasmo.',
    'El éxito es la satisfacción de saber que estás haciendo todo lo posible para convertirte en lo mejor que eres capaz de ser.',
    'El éxito es la recompensa para aquellos que se levantan más veces de las que caen.',
    'El éxito es la capacidad de ir de un fracaso a otro sin perder el entusiasmo.',
    'El éxito es la satisfacción de hacer lo que te gusta y amar lo que haces.',
    'El éxito es la capacidad de ir de un fracaso a otro sin perder el entusiasmo.',
    'El éxito es la satisfacción de hacer lo que te gusta y amar lo que haces.',
    'El éxito es la capacidad de ir de un fracaso a otro sin perder el entusiasmo.',
  ];

  @override
  Widget build(BuildContext context) {
    final emotionModel = Provider.of<EmotionModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Selecciona tu emoción'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton<String>(
              value: emotionModel.currentEmotion,
              onChanged: (String? newEmotion) {
                if (newEmotion != null) {
                  emotionModel.setEmotion(newEmotion);
                  final quote = motivationalQuotes[
                      Random().nextInt(motivationalQuotes.length)];
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(quote)),
                  );
                }
              },
              items: emotions.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            EmotionContent(),
          ],
        ),
      ),
    );
  }
}

class EmotionContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final emotionModel = Provider.of<EmotionModel>(context);
    String emotion = emotionModel.currentEmotion;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Tu emoción actual es:',
            style: TextStyle(fontSize: 24),
          ),
          Text(
            emotion,
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Icon(
            emotion == 'Feliz'
                ? Icons.sentiment_very_satisfied
                : emotion == 'Triste'
                    ? Icons.sentiment_dissatisfied
                    : emotion == 'Enojado'
                        ? Icons.sentiment_very_dissatisfied
                        : emotion == 'Sorprendido'
                            ? Icons.sentiment_very_satisfied
                            : Icons.sentiment_satisfied,
            size: 100,
            color: emotion == 'Feliz'
                ? Colors.yellow
                : emotion == 'Triste'
                    ? Colors.blue
                    : emotion == 'Enojado'
                        ? Colors.red
                        : emotion == 'Sorprendido'
                            ? Colors.orange
                            : Colors.green,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Share.share(
                  'Estoy ${emotion.toLowerCase()} en mi app de emociones!');
            },
            child: Text('Compartir mi emoción'),
          ),
          SignOutButton(),
        ],
      ),
    );
  }
}
class SignOutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text('Cerrar sesión'),
      onPressed: () async {
        await FirebaseAuth.instance.signOut();
      },
    );
  }
}
