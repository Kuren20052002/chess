<!-- PROJECT LOGO -->
<br />
<div align="center">
  <a href="https://github.com/Kuren20052002/chess">
    <img src="https://static.vecteezy.com/system/resources/previews/017/709/383/non_2x/black-color-chess-piece-set-free-vector.jpg" alt="Logo" " height="80">
  </a>

<h3 align="center">Chess with Ruby</h3>

  <p align="center">
    A chess game implemented in Ruby that runs in a command-line interface (CLI).
  </p>
</div>
---

## Table of Contents

- [About the Project](#about-the-project)
- [Built With](#built-with)
- [Install & Play](#install--play)
- [Instructions](#instructions)
- [Features](#features)
- [Planned Improvements](#planned-improvements)
- [Acknowledgments](#acknowledgments)

---

## Acknowledgments

* [The Odin Project](https://www.theodinproject.com/)
* [README template](https://github.com/othneildrew/Best-README-Template)

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[Ruby-url]: https://www.ruby-lang.org/en/
[Ruby-bagde]: https://img.shields.io/badge/Ruby-CC342D?style=for-the-badge&logo=ruby&logoColor=whiteAbout the Project

This project was created as part of my learning journey through [The Odin Project](https://www.theodinproject.com/). I wanted to explore **object-oriented programming (OOP)** and **test-driven development (TDD)** in Ruby, and chess seemed like the perfect fit: not too simple, not too overwhelming — just enough complexity to practice clean design and reusable class structure.

Additionally, I implemented saving and loading game states via YAML serialization, allowing players to pause and resume.

> Built from August 20, 2024 to August 28, 2024

---

## Built With

- **Ruby**
- **RSpec** – for unit testing and practicing TDD

---

## Install & Play

Follow these steps to install and play the chess game on your local machine:

### Prerequisites

#### Make sure Ruby is installed:

```bash
ruby -v
```
If not installed, download Ruby from ruby-lang.org.

### Installation
 Clone the repository:

```
git clone https://github.com/Kuren20052002/chess.git
```
Navigate to the project folder:

```
cd chess
```

Run the game:
```
ruby main.rb
```
##### Tip: The game runs in a command-line interface (CLI), so use a terminal that supports user input/output.

### Instructions
#### Here are the basic rules:

- Move pieces using their valid movement rules.

- To make a move, enter the starting and ending positions (e.g., e2 e4).

- Type board to see the current board.

- Type help to view the instructions again.

- Type O-O or O-O-O for castling (short/long).

- Type save to save the current game to a .yml file.

- Type quit to exit the game.

- If you're in check, you must move out of check.

1. Checkmate wins the game.

🎉 Good luck and have fun!

---

##  Features
- Full standard chess rules (except 50-move draw rule)

- Castling (short & long)

- Check and checkmate detection

- Turn-based CLI interface

- Save & resume game from .yml file

- Built using TDD with RSpec

- Structured with object-oriented design (OOP)

### Planned Improvements
- Add the 50-move draw rule

- Move the game to a Rails web GUI version

- Possibly add AI player

---

## Acknowledgments

* [The Odin Project](https://www.theodinproject.com/)
* [README template](https://github.com/othneildrew/Best-README-Template)

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[Ruby-url]: https://www.ruby-lang.org/en/
[Ruby-bagde]: https://img.shields.io/badge/Ruby-CC342D?style=for-the-badge&logo=ruby&logoColor=white
