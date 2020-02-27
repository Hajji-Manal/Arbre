# Arbre
Pour ce projet, chaque noeud d'un arbre généalogique comprend l'identifiant unique de
l'individu et des informations sur l'individu comme par exemple son nom, son prénom, son
sexe, sa date de naissance, etc. Dans la suite du sujet, on n'exploitera pas ces informations.
On pourrait envisager une version où on ne conserve que l'année de naissance de l'individu,
une autre où on conserve prénom, nom, sexe, date de naissance, lieu de naissance, date de
décès, etc.

Nous avons caractérisé précédemment chaque personne par un identifiant (ou une clé)
unique représenté par un entier.
On souhaite compléter chaque identifiant par l'ensemble des informations d'état civil
d'une personne comme le nom, le prénom, la date de naissance, le lieu de naissance, etc.
En quelque sorte, il s'agit de définir un registre d'état civil qui est accédé par l'identifiant
de la personne (la clé).

Ce registre pouvant contenir un nombre élevé de personnes, il faudra veiller à avoir un
accès efficace aux informations d'une personne.

En plus des informations que peut fournir ce registre, sa définition permet de contrôler
la cohérence de l'arbre généalogique construit. Par exemple, on ne pourra pas définir un
parent plus jeune que son enfant. D'autres contraintes peuvent être définies.
