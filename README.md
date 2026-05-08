<h1 align="center">IFighters</h1>

Este é o repositório do jogo para o projeto final, aqui você encontra a estrutura inicial, e, neste arquivo você encontra as instruções e pequenos tutoriais sobre como vamos prosseguir com o projeto:

---
<br>

# Arquitetura das pastas

Esta será a arquitetura utilizada nas pastas do projeto:

```
res://
├── Assets/
│   ├── Audios/
│   ├── Sprites/ (Gerais: itens, ícones)
│   ├── VFX/ (Impactos, partículas)
│   └── Fonts/ (Fundamental para UI)
├── Entities/
│   ├── PastaExemploAluno/ (Base ou classes comuns)
│   ├── Prof_Matematica/ (Cena, Script e Sprites específicos aqui)
│   └── Resources/ (Arquivos .tres)
├── Scenes/
│   ├── Scenarios/
│   └── UI/ (Menus, HUD)
├── Scripts/
│   ├── Global/ (Singletons/Autoloads como MusicPlayer ou GlobalStats)
│   └── Utils/ (Scripts genéricos)
└── ...
```

---
<br>

# Tecnologias utilizadas:

* [Git](https://git-scm.com/install/) para o versionamento local

* [GitHub](https://guthib.com/) para o versionamento remoto e trabalho conjunto

* [Git Large File Storage](https://git-lfs.com/) para o gerenciamento de grandes arquivos no Git (Necessário apenas no Linux)

* [Godot Engine](https://godotengine.org/download/) para o desenvolvimento do Jogo


---
<br>

# Padronizações:

* Para variaveis utilizaremos o [camelCase](https://bit.ly/3PoA6sx)

* Para funções a [PascalCase](https://bit.ly/3PoA6sx)

## Conventional Commits:

### Tipos Principais

- **feat**: Nova funcionalidade  

  ```bash
  git commit -m "feat: criar classe inicial do player"
  ```

- **fix**: Correção de bug  

  ```bash
  git commit -m "fix: corrigir erro de seleção de personagem"
  ```
- **docs**: Alterações na documentação  

  ```bash
  git commit -m "docs: atualizar README"
  ```
- **style**: Formatação, espaços, ponto e vírgula (não altera lógica) 

  ```bash
  git commit -m "style: formatar código com prettier"
  ```
- **refactor**: Refatoração de código (sem adicionar funcionalidade nem corrigir bug)  

  ```bash
  git commit -m "refactor: extrai logica de ataque para o devido local"
  ```
- **test**: Adicionar ou corrigir testes 

  ```bash
  git commit -m "test: adicionar testes execução "
  ```
- **chore**: Atualização de dependências, tarefas de build, configurações

  ```bash
  git commit -m "chore: configurar GitHub Actions"
  ```
- **build**: Alterações que afetam o sistema de build  

  ```bash
  git commit -m "build: configurar webpack para produção"
  ```

---
<br>

# Workflow
- Trabalharemos em [branches](https://www.youtube.com/watch?v=lq3nawUnpEI): 

`feature -> develop -> main` 

- A branch `feature` será o codigo em desenvolvimento, o nome será a feature em desenvolvimento.

- A branch `develop` será o local do [PullRequest](https://www.youtube.com/watch?v=RNbKd8cD0LI) e será o local anterior à main, a versão instável.

- A branch `main` será o código estável e pronto para compilar.

## Passo a passo:

- Clone o repositório(será feito apenas uma vez):

  ```bash
  git clone https://github.com/Pedro-estorgonofekk/IFighters.git
  ```
- A partir desse ponto utilizaremos para a sincronização:

  ```bash
  git checkout main
  git pull origin main --rebase
  git checkout -b feat/nome-da-feature
  ```

- Faça normalmente, tenha em mente que os commits são checkpoints, recomendo que faça pequenos commits e no fim faça o push

  ```bash
  # Verificar os arquivos alterados e branch em trabalho
  git status

  # Adicionar arquivos trabalhados
  git add .

  # Commitar arquivos
  git commit -m "<tipo>: <mensagem>"

  # Subir para o repositório remoto
  git push origin feat/nome-da-feature
  ```

---
<br>

# Tutoriais:

## 1. Nivelamento de Git

* [O'que são branches](https://www.youtube.com/watch?v=lq3nawUnpEI)

* [O'que são PullRequest](https://www.youtube.com/watch?v=RNbKd8cD0LI)

## 2. Aprendendo Godot 4

* [Tutorial base da Godot (recomendável seguir a playlist)](https://youtu.be/O7R87B_xCs8?si=7rHgB6tHaKdJq1AE)

* [Todos os nodes da Godot explicados](https://youtu.be/22VYNOtrcgM?si=xinKxEYl1FQDqfQU)

* [Guará Programador, um canal de tutoriais da Godot](https://www.youtube.com/@guaraprogramador)

* [Clécio Espindola, game developer de godot](https://www.youtube.com/@clecioespindolagamedev)

---
<br>

# ⚠️ Dicas de sobrevivência ⚠️

* **Feche a Godot antes de grandes manobras:** Quando for trocar de branch, fazer o `git pull --rebase` feche a engine pra evitar corromper os arquivos.

* **O jogo deve estar "Compilavel:"** Antes de fazer o push tenha certeza de testar para evitar que outrem faça a sincronia com build quebrada.

* **Não altere os arquivos dos outros:** Caso seja necessário dentro da cena de outro colega, avise-o ou peça pra ele criar um `signal` global, ou até mesmo uma função pública.

* **Instruções:** Caso necessário faça um `README.md` para passar as instruções do código na raiz do seu diretório de trabalho, recomendo o site [MarkdownPreview](https://markdownlivepreview.com/)