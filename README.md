# Desafio Flutter - Tokio Marine

Este repositório contém a solução para o desafio de código para a vaga de Desenvolvedor Flutter Pleno na Tokio Marine. O objetivo foi desenvolver um aplicativo com um fluxo de autenticação completo, demonstrando boas práticas de desenvolvimento e arquitetura de software.


### TODO  COR ROXA DOS FORM FIELDS TEM QUE MUDAR
### TODO MELHORAR O DESIGN DO DIALOG E ADICIONAR O ACTION BUTTON
### TODO COLOCAR O ESPACAMENTO DOS ITENS DA HOME IGUAL O DO MOCK DISPONIBILIZADO

## ✨ Funcionalidades

- **Autenticação de Usuário:**
  - **Cadastro:** Permite que novos usuários se registrem com nome, e-mail, CPF e senha.
  - **Login:** Autenticação segura utilizando CPF e senha.
  - **Logout:** Encerra a sessão do usuário.
- **Validação de Formulários:** Validação de dados em tempo real para garantir a integridade das informações.
- **Gerenciamento de Sessão:** O aplicativo reage ao estado de autenticação do usuário, direcionando-o para a tela de login ou para a home.
- **Interface Moderna:** UI limpa e responsiva, adaptada para diferentes tamanhos de tela.

---

## 🛠️ Arquitetura e Tecnologias

O projeto foi estruturado seguindo os princípios da **Clean Architecture**, visando um código desacoplado, testável e de fácil manutenção.

- **Camadas:**
  - `Presentation`: Responsável pela UI e gerenciamento de estado (Widgets, BLoC).
  - `Domain`: Contém as regras de negócio e entidades da aplicação (Use Cases, Repositories, Entities).
  - `Data`: Implementa a lógica de acesso a dados, seja de fontes remotas ou locais (Repositories Impl, Data Sources).

- **Principais Tecnologias Utilizadas:**
  - **Gerenciamento de Estado:** `flutter_bloc` para um controle de estado reativo e previsível.
  - **Injeção de Dependência:** `get_it` para desacoplar as classes e facilitar a substituição de dependências em testes.
  - **Backend:** **Firebase** (`FirebaseAuth` para autenticação e `Cloud Firestore` para armazenamento de dados do usuário).
  - **Tratamento de Erros:** `dartz` para uma abordagem funcional no tratamento de falhas e sucessos, tornando o fluxo mais robusto.
  - **Validação:** Validadores customizados para os campos de entrada.
  - **Conectividade:** `internet_connection_checker_plus` para verificar a conexão com a internet antes de operações de rede.

---

## 🚀 Como Executar

1.  **Clone o repositório:**
    ```sh
    git clone <URL_DO_SEU_REPOSITORIO>
    ```


2.  **Instale as dependências:**
    ```sh
    flutter pub get
    ```

3.  **Execute o aplicativo:**
    ```sh
    flutter run
    ```

