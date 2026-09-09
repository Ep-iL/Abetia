# Abetia - Souls-like MVP

Um jogo 3D inspirado em Dark Souls, desenvolvido com **Godot Engine** e **GDScript**.

## 🎮 Sobre o Projeto

Este é um **MVP (Minimum Viable Product)** de um jogo tipo Souls-like, focando nas mecânicas essenciais:

- **Movimento do personagem** em 3D
- **Câmera em primeira pessoa**
- **Combate básico** (ataque com range detection)
- **IA de inimigo** simples (chase + attack)
- **Sistema de saúde** para player e inimigos

## 🚀 Como Rodar

### Requisitos
- [Godot Engine 4.1+](https://godotengine.org/)

### Passos

1. Clone o repositório:
```bash
git clone https://github.com/Ep-iL/Abetia.git
cd Abetia
```

2. Abra o projeto no Godot:
   - Abra o Godot Editor
   - Clique em "Open Project"
   - Navegue até a pasta `Abetia`
   - Clique em "Select Current Folder"

3. Execute o jogo:
   - Pressione `F5` ou clique em "Run"

## 🎮 Controles

| Ação | Tecla |
|------|-------|
| Mover | WASD |
| Pular | Espaço |
| Atacar | Tab |
| Câmera | Mouse |
| Menu | ESC |

## 📁 Estrutura do Projeto

```
Abetia/
├── scenes/
│   ├── main/
│   │   └── main.tscn          # Cena principal
│   ├── player/
│   │   └── player.tscn        # Cena do jogador
│   └── enemy/
│       └── enemy.tscn         # Cena do inimigo
├── scripts/
│   ├── main.gd
│   ├── player/
│   │   └── player.gd          # Lógica do jogador
│   └── enemy/
│       └── enemy.gd           # Lógica do inimigo
├── project.godot              # Configuração do projeto
└── README.md
```

## 🎯 Roadmap (Próximas Features)

- [ ] Mais inimigos e variações
- [ ] Sistema de armas/equipamentos
- [ ] Boss fights
- [ ] Procedural level generation
- [ ] Dodge/Roll system
- [ ] Parry/Block mechanics
- [ ] Death penalty (lose currency)
- [ ] Checkpoint/Bonfire system
- [ ] Levels/World design
- [ ] UI/HUD completo

## 📝 Notas de Desenvolvimento

- O MVP foca em gameplay loop básico: movimento, combate, morte
- Inimigos têm IA simples de chase + attack
- Dano é detectado por raycasts/spherecasts
- Sistema de câmera é em primeira pessoa com sensibilidade ajustável

## 🛠️ Contribuindo

Sinta-se livre para fazer fork, melhorar e criar pull requests!

## 📄 Licença

Este projeto é open source sob licença MIT.

---

**Abetia** - Onde todo herói cai, e se levanta novamente. ⚔️
