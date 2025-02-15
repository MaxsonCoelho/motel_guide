📍 Go - Aplicativo de Busca de Motéis 🚀
Desenvolvido por Maxson Coelho
 Plataformas: Android & iOS
Arquitetura: Clean Architecture + Riverpod + SOLID

📌 Sobre o Projeto
O Go é um aplicativo desenvolvido em Flutter para facilitar a busca e reserva de motéis, oferecendo uma experiência fluida, rápida e responsiva tanto para Android quanto iOS.

O app conta com uma interface moderna, animações bem trabalhadas, temas dinâmicos, componentização eficiente e testes automatizados para garantir alta qualidade e escalabilidade.

📌 Tecnologias Utilizadas
Flutter 3.x
Dart
Riverpod (Gerenciamento de Estado)
Clean Architecture
SOLID Principles
HTTP Client (Mock para requisições de imagens)
Flutter Test (Testes unitários e de widget)
Shimmer Effect (Efeito de pré-carregamento)
Responsividade (Adaptação para múltiplos dispositivos)
--------------------------------------------------------------

🚀 Instalação e Execução

🛠️ Pré-requisitos
Flutter 3.x instalado 
Dart SDK atualizado
Android Studio
Emulador ou dispositivo físico conectado

Instalando Dependências
flutter pub get

🏃‍♂️ Rodando no Emulador ou Celular
flutter run

💻 Rodando em Plataformas Específicas
flutter run -d android   # Para rodar no Android  
flutter run -d ios       # Para rodar no iOS  

🧪 Rodando os Testes Automatizados
flutter test
📌 Gerando um APK para Testes
Gerar APK Debug (rápido para testes internos)
flutter build apk --debug
📂 O APK será salvo em:
build/app/outputs/flutter-apk/app-debug.apk 

🔹 Gerar APK de Produção (otimizado e assinado)
flutter build apk --release
📂 O APK será salvo em:
build/app/outputs/flutter-apk/app-release.apk

🔹 Instalando o APK no Dispositivo
adb install build/app/outputs/flutter-apk/app-debug.apk
--------------------------------------------------------------

📌 Padrões de Código e Boas Práticas
✔ Código bem estruturado e modularizado
✔ Uso de Riverpod para gerenciamento de estado de forma otimizada
✔ Componentização com widgets reutilizáveis
✔ Uso de Shimmer para pré-carregamento
✔ Uso correto de const, final e late para otimização de performance
✔ Segurança: Validação de entrada de dados
--------------------------------------------------------------

📌 Arquitetura do Projeto
O projeto segue Clean Architecture, separando camadas de apresentação, domínio e dados para manter um código escalável, testável e de fácil manutenção.

📂 Estrutura do projeto:
📂-lib/
│── 📂 core/                 # Core do projeto (configurações globais, temas, etc.)
│── 📂 models/               # Modelos de dados
│── 📂 providers/            # Gerenciamento de estado com Riverpod
│── 📂 screens/              # Telas do app
│── 📂 widgets/              # Componentes reutilizáveis
│── 📂 utils/                # Funções utilitárias
│── main.dart                # Ponto de entrada do app
│── app_theme.dart           # Tema global do app
📂-tests                        # Módulo de arquivos de testes unitários

📌 Princípios SOLID aplicados:
✔ Single Responsibility Principle (SRP): Cada classe tem uma única responsabilidade.
✔ Open/Closed Principle (OCP): O código é extensível sem precisar ser modificado.
✔ Liskov Substitution Principle (LSP): As subclasses podem substituir suas classes base sem alterar o comportamento do sistema.
✔ Interface Segregation Principle (ISP): Interfaces específicas para cada caso de uso.
✔ Dependency Inversion Principle (DIP): Dependências são injetadas, evitando acoplamento excessivo.

📌 Recursos do App
Tema Responsivo com suporte a modo claro e escuro(configuração de temas)
Carrossel Automático de suítes com descontos
Lista interativa de motéis com animações e pré-carregamento (Shimmer)
Testes automatizados de widgets e unitários
Gerenciamento de estado eficiente com Riverpod
Animações suaves na tela de preload
Integração com APIs (mockadas para este projeto)


📌 Vídeos do app em funcionamento
Versão android
https://youtube.com/shorts/dr1Y8aUhiwU?feature=share
Versão ios
https://youtube.com/shorts/-7iciakI5i4?feature=share

Devido a falta de qualidade do vídeo postado no youtube também coloquei os vídeos para baixar ou assitir nesse link do drive
https://drive.google.com/drive/folders/15OfGzF9LrnVjXCZjGLrdODoAlReY-vYJ?usp=sharing

