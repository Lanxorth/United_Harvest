# United Harvest — contexte projet

- Dépôt : https://github.com/Lanxorth/United_Harvest.git
- Unreal Engine 5.7 et Windows 11, à confirmer localement.
- Projet fortement orienté Blueprints.
- Objectif : agents développeurs externes au jeu, capables d'assister le code C++ et les assets/Blueprints dans l'éditeur.

## Règles
1. Inspecter les assets, graphes et dépendances avant toute modification.
2. Réutiliser les systèmes existants, notamment BPI_Interact et BP_BaseItem s'ils sont présents.
3. Ne jamais déduire le contenu d'un graphe depuis le seul nom de l'asset.
4. Ne pas supprimer/renommer/remplacer d'asset sans approbation.
5. Compiler les Blueprints modifiés et rapporter les erreurs.
6. Ne pas lancer d'action destructive, de push Git ou de modification massive sans approbation.
7. Séparer les faits vérifiés des hypothèses.

Pistes documentaires à vérifier : BP_Player, BPI_Interact, BP_InteractChecker, BP_BaseItem, S_ItemInfo, base de données d'objets, IDs/enums, lancer d'objets avec impulsion.
