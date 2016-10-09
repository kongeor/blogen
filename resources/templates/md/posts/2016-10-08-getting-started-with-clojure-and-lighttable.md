{:title "Getting started with clojure and LightTable"
 :layout :post
 :tags  ["clojure" "lighttable"]}

If you are new to clojure you should consider [LightTable][lighttable] as
it is very easy to setup and get started.


### Installing the required software

Make sure that you have jdk 7 or greater installed. This
can be either [oracle jdk][oraclejdk] or [openjdk][openjdk]
depending on your preference and `OS`.


To verify it run:

```sh
➜ java -version
java version "1.8.0_102"
Java(TM) SE Runtime Environment (build 1.8.0_102-b14)
Java HotSpot(TM) 64-Bit Server VM (build 25.102-b14, mixed mode)

```

Download [Leiningen][leiningen] and follow the installation instructions.

Download [LightTable][lighttable] and extract it.


### Generating a Leiningen project

`Leiningen` is a dependency managment and build automation tool
for `clojure` projects.

In order to create a `leiningen` project all you have to do is:

```sh
➜ lein new hello
```

This will generate a scaffold for a project named `hello` using the
default template.


### Opening the project in LightTable

Fire up `LightTable` from the extracted directory.

Go to `File ➜ Open Folder` and open the `hello` folder that was generated
by `leiningen`.

From the navigation pane on the left browse and open the `src ➜ hello ➜ core.clj` file.


### Interacting with the code


What makes `clojure` particularly special is that it enables you to develop
your code _interactively_.


Place the cursor anywhere inside the `(defn foo ... )` function and hit `ctrl + enter`.
You should see a progress indication in the status status and
a highlighted `#'hello.core/foo` message near the `foo` function
after a while (this process takes a bit more during the first time).

So, what did just happen?

A `clojure` `REPL` has been started under the scenes and we just compiled and loaded
the `foo` function on it. This might don't seem like a big deal but it actually is.

To get a feeling why, try the following: delete the `foo` function, and create a new one:

```clojure
(defn add [x y]
  (+ x y))
```

Evaluate it by hitting `ctrl + enter` as before. Type below:

```clojure
(add 5 3)
```

and evaluated the call. You should see a highlighted `8` next to `(add 5 3)`.

Try changing the `add` function by adding an extra parameter or make it do
division instead, re-evaluate `add` and then evaluate the call again.


### Just enough customization

Probably you want to change `LightTable`'s default font and theme.

Hitting `ctrl+space` will open a pane on the right. Type `settings` and
select `Settings: User behaviors`.

Find the following line:

```clojure
[:editor :lt.objs.style/set-theme "default"]
```

Remove the `default` text and hit `tab`. You should see a drop-down list
with all the themes `LightTable` supports out of the box. Make your selection,
save the file and you should see the changes right away.

Below there is the following line:

```clojure
;; [:app :lt.objs.style/font-settings "Courier New" "11"]
```

Remove `;;`. Lines starting with a `;` are considered comments and they
are quite distinctive by being grayed-out. Set the font family and size of
your preference and save.

`LightTable` also supports fonts with programming ligatures like [Fira Code][firacode].

You can find configuration instructions [here][firatable].


### Configure `paredit`

If you are going to play around with `clojure` for a while, you should consider getting familiar
with the `paredit` plugin as it can really make your life a lot easier.

The `paredit` plugin is installed by default but you have to configure some key
bindings in order to use it.
Hit `ctrl + space`, type `user keymap` and open the `Settings: User keymap`.

Add the following lines just before the final closing bracket `]`:

```clojure
[:editor "ctrl-shift-k" :paredit.grow.right]
[:editor "ctrl-shift-j" :paredit.shrink.right]
```

To see it in action, go to the editor, and evaluate the following:

```clojure
(range 10)
```

Now type `(reduce +)` before the previous form:
```clojure
(reduce +) (range 10)
```

Place the cursor inside the `(reduce +)` form and hit `ctrl-shift-k`, you should see
the `(range 10)` wrapped as follows:

```clojure
(reduce + (range 10))
```

If you hit `ctrl-shift-j` you will see the form being unwrapped.

Check [this SO post][lt-cheat-sheet-so] if you want to configure more `paredit` commands.

### Where to go from here

If you prefer to read a book about clojure you should check
[Clojure for the Brave and True][braveclojure] which is available online
for free.

If you prefer solving problems then there are a number of options:

* [4clojure][4clojure]
* [clojure koans][cljkoans]
* [codewars][codewars]
* [exercism.io][exercism]

Although it might be a bit tough for beginners, you should check `clojure`'s
[reference documentation][reference].

Have fun!

[oraclejdk]: http://www.oracle.com/technetwork/java/javase/downloads/index.html
[openjdk]: http://openjdk.java.net/
[leiningen]: http://leiningen.org/
[lighttable]: http://lighttable.com/
[lt-cheat-sheet-so]: http://stackoverflow.com/questions/22168195/i-cant-find-a-light-table-cheat-sheet
[firacode]: https://github.com/tonsky/FiraCode
[firatable]: https://github.com/tonsky/FiraCode/wiki/LightTable-instructions

[braveclojure]: https://foo.example.com
[cljkoans]: saja
[4clojure]:  asdf
[codewars]: https://www.codewars.com/
[exercism]: http://exercism.io/
[reference]: http://clojure.org/reference/documentation
