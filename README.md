# Desafio Flutter - Tokio Marine

![Status](https://img.shields.io/badge/status-concluído-green)
![Flutter](https://img.shields.io/badge/Flutter-3.24.5-blue?logo=flutter)
![Firebase](https://img.shields.io/badge/Firebase-SDK-orange?logo=firebase)

Solução completa para o desafio de código da vaga de Desenvolvedor Flutter Pleno na Tokio Marine. O projeto consiste em um aplicativo mobile com um fluxo de autenticação robusto e uma interface de usuário moderna e responsiva, desenvolvido com foco em boas práticas de arquitetura e qualidade de código.

## 🔗 Acesso ao Projeto / Deploy

A aplicação está hospedada com Firebase Hosting e pode ser acessada através do link abaixo:

**[Acessar a versão web do aplicativo](https://tokio-2ab9a.web.app/)**
> **Nota:** A aplicação foi desenvolvida e validada também para uso em dispositivos móveis. Caso prefira, você poderá avaliá-la diretamente pelo navegador utilizando as ferramentas de desenvolvedor no modo responsivo/mobile.

## 📸 Capturas de Tela  


| Tela de Login | Tela de Cadastro | Página Inicial |
| :-----------: | :--------------: | :------------: |
| ![](https://raw.githubusercontent.com/iceesousa/tokio_marine/main/prints/entrar.png) | ![](https://raw.githubusercontent.com/iceesousa/tokio_marine/main/prints/cadastrar.png) | ![](https://raw.githubusercontent.com/iceesousa/tokio_marine/main/prints/inicio.png) |


## ✨ Funcionalidades Principais

-   ✅ **Fluxo de Autenticação Completo:**
    -   **Cadastro de Usuário:** Registro seguro com nome, e-mail, CPF e senha.
    -   **Login:** Autenticação de usuários existentes via CPF e senha.
    -   **Logout:** Encerramento seguro da sessão do usuário.
-   🔒 **Gerenciamento de Sessão:** O estado da aplicação reage dinamicamente à autenticação, direcionando o usuário para a tela correta (Login ou Home).
-   📝 **Validação de Formulários em Tempo Real:** Feedback instantâneo para o usuário, garantindo a integridade dos dados antes do envio.
-   📱 **Interface Responsiva:** UI limpa e moderna que se adapta a diferentes tamanhos e orientações de tela.
-   🌐 **Verificação de Conectividade:** Checagem de conexão com a internet antes de realizar operações de rede para uma melhor experiência do usuário.

---

## 🛠️ Arquitetura e Tecnologias

O projeto foi desenvolvido seguindo os princípios da **Clean Architecture**, dividindo o código em camadas de responsabilidade para garantir um sistema desacoplado, testável e de fácil manutenção.

### Arquitetura em Camadas

-   **`Presentation`**: Camada responsável pela UI (Widgets) e pelo gerenciamento de estado, utilizando o padrão **BLoC**.
-   **`Domain`**: Contém as regras de negócio puras, entidades e os contratos dos repositórios (Abstrações). É o coração da aplicação, totalmente independente de frameworks.
-   **`Data`**: Implementa os repositórios definidos no `Domain` e gerencia as fontes de dados (Data Sources), sejam elas remotas (Firebase) ou locais.

### Principais Tecnologias Utilizadas

-   **Gerenciamento de Estado:** `flutter_bloc` para um controle de estado reativo, previsível e escalável.
-   **Injeção de Dependência:** `get_it` para gerenciar a injeção de dependências, facilitando o desacoplamento e os testes.
-   **Backend (BaaS):** **Firebase** para uma solução de backend robusta e escalável:
    -   `FirebaseAuth` para o sistema de autenticação.
    -   `Cloud Firestore` para o armazenamento de dados dos usuários.
-   **Tratamento de Erros Funcional:** `dartz` para lidar com operações que podem falhar (como chamadas de API) de forma explícita e segura, utilizando `Either` para representar Sucesso ou Falha.
-   **Conectividade:** `internet_connection_checker_plus` para verificar o status da conexão com a internet.
-   **Validação:** Validadores customizados para garantir a integridade e o formato correto dos dados de entrada.

---

## 🚀 Como Executar o Projeto Localmente

Siga os passos abaixo para executar o projeto em sua máquina.

### Pré-requisitos

-   [Flutter SDK](https://flutter.dev/docs/get-started/install) (versão 3.x ou superior)
-   Um editor de código como [VS Code](https://code.visualstudio.com/) ou [Android Studio](https://developer.android.com/studio).
-   Uma conta no [Firebase](https://firebase.google.com/) para configurar o backend. (Tambem pode pular esse passo e utilizar o meu backend).

### Passos para Execução

1.  **Clone o repositório:**
    ```sh
    git clone https://github.com/iceesousa/tokio_marine.git](https://github.com/iceesousa/tokio_marine.git
    cd tokio_marine
    ```

2.  **Configuração do Firebase:**
    -   Crie um novo projeto no [console do Firebase](https://console.firebase.google.com/).
    -   Configure um aplicativo para **Android** ou **Web**.
    -   Siga as instruções para adicionar o arquivo de configuração ao seu projeto Flutter (ex: `google-services.json` para Android ou o snippet de configuração para Web).
    -   Ative os serviços **Authentication** (com o provedor E-mail/Senha) e **Cloud Firestore**.

> ⚠️ **Nota:** Você pode pular essa etapa se desejar utilizar o backend já configurado por mim.

3.  **Instale as dependências do projeto:**
    ```sh
    flutter pub get
    ```

4.  **Execute o aplicativo:**
    ```sh
    flutter run
    ```

---

## 💡 Melhorias Futuras e Próximos Passos

Apesar do tempo limitado para o desenvolvimento, a base do projeto foi construída para ser escalável. Abaixo estão alguns pontos que seriam os próximos passos naturais para evoluir a aplicação:

-   **Cobertura de Testes:** Implementar testes unitários para os `DataSources`, `Repositories` e `BLoCs`, e testes de widget para os principais componentes da UI.
-   **Recuperação de Senha:** Adicionar um fluxo de "Esqueci minha senha" utilizando os serviços do Firebase.
-   **CI/CD (Integração e Entrega Contínua):** Configurar um pipeline com GitHub Actions para automatizar os testes e o processo de build.
-   **Animações e Microinterações:** Adicionar animações sutis para melhorar a experiência do usuário.
