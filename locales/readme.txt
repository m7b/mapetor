For initially generating a pot file:

1. xgettext -k_ --c++ --from-code=utf8 -j -D ../src EModul.cpp -o PSSu2_PIunraveler.pot
2. open PSSu2_PIunraveler.pot with poedit
3. add search directories for source files in Katalog/Eigenschaften/Quellpfade
4. add _ in Katalog/Eigenschaften/Schlüsselwörter aus Quelltexten
