# Template Branvier

## Instalação

### 1. Clone o repositório

### 2. Configure o nome do projeto
No `pubspec.yaml`, altere o `name` do projeto. Palavra única, sem espaços, sem caracteres especiais, sem ponto final. Ex: `smartkeeping`.

### 3. Execute o comando de criação
```bash
flutter create . --org com.branvier
```

### 4. Configure o serviço

Considere apagar a pasta `/services/api` ou `services/firebase` se não for usar.

#### Se Backend:
Configure a baseUrl em `env.dart`.

#### Se Firebase:
Rode os seguintes comandos no terminal, retire os produtos firebase que não forem user inicialmente:

```bash
dart pub add firebase_core, firebase_auth, cloud_firestore, cloud_functions, firebase_storage, firebase_analytics, firebase_crashlytics, firebase_messaging
```

Configure o Firebase no seu projeto:

```bash
firebase login
flutterfire configure
```

Referência: https://firebase.flutter.dev/docs/overview.

### 5. Revise os providers
Revise os providers em `main.dart` e adicione os que forem necessários.
