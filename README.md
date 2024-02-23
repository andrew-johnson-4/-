# [Lambda Mountain](https://github.com/andrew-johnson-4/-/wiki)

λ☶ (pronounced Lambda Mountain) is a compiler backend.
It is a typed fragment assembler,
which means it could generate machine code,
but right now the only backend targets GNU Assembler.

More information is available on the [λ☶ Wiki](https://github.com/andrew-johnson-4/-/wiki).

There is also a [Bootstrap Book](https://github.com/andrew-johnson-4/BootstrapBook) that explains the compiler internals in great detail.

### What is Ad-Hoc Specialization?

If we have several overloaded functions then specialization lets us choose the best fit for any particular application.

```
f := λ(: x X). x;
f := λ(: y Y). y;

f (: x X)
```

In this example the function application does not “fit” the application that expects a Y type argument, so there is only one possible candidate function.

```
type X implies Y;

f := λ(: x X). x;
f := λ(: y Y). y;

f (: x X)
```

Now both candidate functions “fit”, however X is a narrower type than Y. All X are Y, but not all Y are X. In this case we say that X is a “better fit” than Y.

### How does Ad-Hoc Specialization Work?

The language here is based on [System F-sub](https://en.wikipedia.org/wiki/System_F) with the following inference rules added.

$$abstraction \quad \frac{\Gamma \vdash a:A \quad \Gamma \vdash b:B \quad \Gamma \vdash x:X \quad \Gamma \vdash y:Y \quad λ⟨a.b⟩⟨x.y⟩}{\Gamma \vdash λ⟨a.b⟩⟨x.y⟩:(A \to B) + (X \to Y)}$$

$$application \quad \frac{\Gamma \vdash f:(A \to B) + (C \to D) + (X \to Y) \quad \Gamma \vdash x:A + X \quad f(x)}{\Gamma \vdash f(x):B + Y}$$

<a href="https://github.com/andrew-johnson-4/-/wiki#mascot"> <img src="https://raw.githubusercontent.com/andrew-johnson-4/-/main/DOBY.jpg" height=200 title="Doby being a prototypical ass."> </a>

