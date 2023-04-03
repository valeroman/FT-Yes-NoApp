# yes_no_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Instalar Provider
Documentacion: https://pub.dev/packages/provider

- Instalación: `flutter pub add provider`
- Abrimos el archivo `pubspec.yaml`
- Verificamos que la libreria este ahí:
    ```
    dependencies:
    flutter:
        sdk: flutter


    # The following adds the Cupertino Icons font to your application.
    # Use with the CupertinoIcons class for iOS style icons.
    cupertino_icons: ^1.0.2
    provider: ^6.0.5
    ```
## Como Usar el Provider

- Abrimos el archivo `main.dart` y envolvemos el widget `MaterialApp` en un nuevo widget
- Le colocamos un nombre a ese nuevo widget `MultiProvider` e importamos su paquete `import 'package:provider/provider.dart';`
- Al MultiProvider, requiere un parametro llamado `providers`
- En `providers`, Colocamos el `ChangeNotifierProvider( create: (_) => ChatProvider() )`
- Asi creamos nuestro `ChatProvider` a nivel global de la aplicación
```
    import 'package:flutter/material.dart';
    import 'package:provider/provider.dart';
    import 'package:yes_no_app/config/app_theme.dart';
    import 'package:yes_no_app/presentation/providers/chat/chat_provider.dart';
    import 'package:yes_no_app/presentation/screens/chat/chat_screen.dart';

    void main() => runApp(const MyApp());

    class MyApp extends StatelessWidget {
    const MyApp({super.key});

    @override
    Widget build(BuildContext context) {
        return MultiProvider(
        providers: [
            ChangeNotifierProvider( create: (_) => ChatProvider() )
        ],
        child: MaterialApp(
            title: 'Yes No App',
            debugShowCheckedModeBanner: false,
            theme: AppTheme( selectedColor: 0 ).theme(),
            home: const ChatScreen(),
        ),
        );
    }
    }
```
- En el archivo `chat_screen.dart`, agregamos el siguiente código:
```
    import 'package:flutter/material.dart';
    import 'package:provider/provider.dart';
    import 'package:yes_no_app/presentation/providers/chat/chat_provider.dart';
    import 'package:yes_no_app/presentation/widgets/chat/her_message_bubble.dart';
    import 'package:yes_no_app/presentation/widgets/chat/my_message_bubble.dart';
    import 'package:yes_no_app/presentation/widgets/shared/message_field_box.dart';

    import '../../../domain/entities/message.dart';

    class ChatScreen extends StatelessWidget {
    const ChatScreen({super.key});

    @override
    Widget build(BuildContext context) {
        return Scaffold(
        appBar: AppBar(
            leading: const Padding(
            padding: EdgeInsets.all(4.0),
            child: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQZ1ZqcK-qcHvzeruslM-GGWmVz0tBRBaOdyA&usqp=CAU'),
            ),
            ),
            title: const Text('Mi amor'),
            centerTitle: false,
        ),
        body: _ChatView(),
        );
    }
    }

    class _ChatView extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        final chatProvider = context.watch<ChatProvider>();

        return SafeArea(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
            children: [
                Expanded(
                    child: ListView.builder(
                itemCount: chatProvider.messageList.length,
                itemBuilder: (context, index) {
                    final message = chatProvider.messageList[index];

                    return (message.fromWho == FromWho.hers)
                        ? const HerMessageBubble()
                        : const MyMessageBubble();
                },
                )),
                // Caja de texto del mensaje
                const MessageFieldBox()
            ],
            ),
        ),
        );
    }
    }

```
