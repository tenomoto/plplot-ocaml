PLplot OCaml examples

Most of [PLplot examples](http://plplot.sourceforge.net/examples.php) are complicated to demonstrate many features of PLplot.
This repository attempts to show that source can be succinct with the PLplot OCaml interface for simple plots.

## How to build

```
$ ocamlbuild -use-ocamlfind contour_gaussian1.native
```

## Contour
* contour_gaussian1.ml: simple contour plot.
* contour_gaussian2.ml: enable command-line option and custom axes.
