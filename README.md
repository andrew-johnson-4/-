# [Lambda Mountain](https://github.com/andrew-johnson-4/-/wiki)

LM aims to provide a convenient interface to formally encode a variety of big-step semantics.
This project is a **User Inferface** for existing theoretical frameworks.
The text language here is a simple encoding of basic lambda calculus and types.
Future work will also be done to provide a zoom-in/zoom-out interface for rules.

<img src="https://raw.githubusercontent.com/andrew-johnson-4/-/main/DOBY.jpg" height=200 title="Doby being a prototypical ass.">

# Syntax and Formatting

In a file `hello_world.lm` put a main function

```
main := λ_. (
   .global _start     \n
   .text              \n
   _start:            \n
   (print_s hello_world)
   \t mov $0 , %rdi   \n # set exit status to 0
   \t mov $60 , %rax  \n # system call 60 is exit
   \t syscall         \n # invoke operating system
);
```

Compile `hello_world` from a shell

```
lambda_mountain -o hello_world hello_world.lm
```

Run the result

```
./hello_world
[stdout] hello_world
```

# How is eval-soft different from eval-hard?

_eval-soft_ attempts to evaluate an expression to normal form with two restrictions:
* the evaluation must not diverge
* the result must be referentially transparent

_eval-hard_ does not have any restrictions.

# Mascot

Doby was a donkey that refused to cross a bridge on the way back from a camping trek.
He was left for dead in the rough wilderness with winter approaching.
Somehow he survived the whole winter under that bridge and was discovered by the game warden the next year.
