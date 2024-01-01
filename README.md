# Lambda Mountain](https://github.com/andrew-johnson-4/-/wiki)

LM aims to provide a convenient interface to formally encode a variety of big-step semantics.
This project is a **User Inferface** for existing theoretical frameworks.
The text language here is a simple encoding of basic lambda calculus and types.
Future work will also be done to provide a zoom-in/zoom-out interface for rules.

<img src="https://raw.githubusercontent.com/andrew-johnson-4/-/main/DOBY.jpg" height=200 title="Doby being a prototypical ass.">

# Syntax and Formatting

LM is a programming language written in the passive voice.
`eval-soft` and `eval-hard` are the exposed entry points into your program.
An LM program is then defined as *capabilities* gifted to anyone with access to your entry points.
LM syntax consists of typed lambda calculus expressions potentially nested inside of rules.

<img src="https://raw.githubusercontent.com/andrew-johnson-4/-/main/equation.png" height=200 title="Equation">

# How is eval-soft different from eval-hard?

_eval-soft_ attempts to evaluate an expression to normal form with two restrictions:
* the evaluation must not diverge
* the result must be referentially transparent

_eval-hard_ does not have any restrictions.

# Mascot

Doby was a donkey that refused to cross a bridge on the way back from a camping trek.
He was left for dead in the rough wilderness with winter approaching.
Somehow he survived the whole winter under that bridge and was discovered by the game warden the next year.
