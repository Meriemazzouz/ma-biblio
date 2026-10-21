Réponses – TP MaBiblio


Q0.8 : Les dossiers build/ et .dart_tool/ sont générés automatiquement par Flutter quand on compile. Ils prennent beaucoup de place et ils dépendent de mon ordinateur. Comme on peut les recréer avec flutter pub get, ça ne sert à rien de les mettre sur GitHub.

Réflexion : Faire plusieurs petits commits permet de voir comment le projet a avancé étape par étape. Si quelque chose ne marche plus, on peut retrouver facilement à quel moment le problème est apparu et revenir en arrière.


Q1.2 : Quand je clique sur "Mon profil", une petite ombre s'étale sur la tuile (l'effet d'encre) et le message "Profil sélectionné" apparaît en bas. Quand j'ai enlevé onTap, il ne se passait plus rien au clic, ni effet ni message.

Q1.4 : Avec dense, la tuile devient plus petite et le texte aussi. Avec isThreeLine, le sous-titre s'affiche sur deux lignes. Avec enabled: false, la tuile devient grise et on ne peut plus cliquer dessus.

Réflexion : leading se met au début de la tuile (à gauche) et trailing à la fin (à droite). Un ListTile essaie de prendre toute la largeur, donc s'il est dans un parent qui n'a pas de largeur limitée, comme une Row, Flutter ne sait pas quelle taille lui donner et ça fait une erreur.


Q2.1 : En ajoutant beaucoup de tuiles, une bande jaune et noire est apparue en bas avec "BOTTOM OVERFLOWED". C'est parce que la Column ne défile pas, donc ce qui dépasse de l'écran est coupé.

Q2.3 : Avec ListTile.divideTiles, je n'ai plus besoin d'ajouter un Divider entre chaque tuile à la main, les séparateurs sont mis automatiquement.

Q2.5 : Pour 1000 livres, ListView.builder est mieux parce qu'il crée seulement les livres qu'on voit à l'écran. Avec une liste children, les 1000 seraient créés d'un coup et l'application serait lente.

Q2.8 : Sans Expanded, j'ai eu une erreur qui parle de hauteur infinie ("unbounded height"). La ListView ne sait pas quelle hauteur prendre dans la Column. Avec Expanded, elle prend juste l'espace qui reste.

Q2.9 : Avec shrinkWrap, la liste prend seulement la place de son contenu et ne défile plus toute seule. Je l'utiliserais pour une petite liste dans une page qui défile déjà.


Q3.1 : Il faut un StatefulWidget parce que l'écran doit changer quand on coche une case. Un StatelessWidget ne peut pas garder ces changements.

Q3.2 : J'ai essayé sans setState : la valeur change dans le code, mais la case ne se coche pas à l'écran parce que Flutter ne redessine pas l'écran.

Q3.5 : Avec leading, la case est à gauche, avec trailing elle est à droite, et avec platform ça dépend du téléphone. J'ai gardé leading.

Q3.6 : La case "Tous les genres" peut avoir trois états : cochée quand tous les genres sont cochés, vide quand aucun ne l'est, et un tiret quand seulement quelques-uns sont cochés.
## Partie 04

Q4.2 : Avec elevation 0, la carte est plate, sans ombre. Avec 4, il y a une petite ombre. Avec 12, l'ombre est beaucoup plus forte et la carte a l'air de flotter.

Q4.3 : color change la couleur de fond de la carte. surfaceTintColor ajoute une teinte par-dessus, qui se voit plus quand l'élévation est grande. shadowColor change la couleur de l'ombre.

Q4.4 : Comme les cartes ont déjà des marges entre elles, le séparateur ne sert plus à rien, donc je suis revenue à ListView.builder.

Q4.5 : Sans Clip.antiAlias, l'effet d'encre dépasse dans les coins arrondis de la carte. Avec, il reste bien à l'intérieur.

Q4.8 : DetailScreen doit être un StatefulWidget parce que quand on clique sur "Ajouter aux favoris", l'icône du cœur doit changer à l'écran.

Q6.3 : Avec SliverGridDelegateWithMaxCrossAxisExtent, on retrouve le même comportement que GridView.extent : on donne une largeur maximale et le nombre de colonnes s'adapte tout seul.

Q7.2 : Si l'indentation de assets n'est pas bonne, flutter pub get donne une erreur ou le fichier n'est pas trouvé au lancement ("Unable to load asset").

Q7.4 : La fonction est async parce que lire un fichier prend un peu de temps. Comme ça, l'application ne se bloque pas pendant le chargement et on voit le cercle de chargement.

Q7.6 : J'ai ajouté un livre dans le JSON et il est apparu sans toucher au code Dart. C'est plus pratique pour modifier les données.

