# Document Technique
## Architecture du projet
Ce projet et réaliser de manière modulaire qui sépare la logique de gameplay, les systèmes d'interaction, la physique et la présentation.

La structure principale est : 
- **Le joueur** : Il contient les mouvement du joueur, gérer les input et s'occupe des interaction spécifique au joueur.
- **Environnement** : Il contient les objets interactif et les élément des niveaux;
- **Système d'interaction** : Donne une interface commune pour détecter et interagir avec les différent objets
- **UI/Présentation** : Gère tous ce qui tien au élément de l'UI, Prompt et élément de feadback.

Cette séparation gardes les systèmes réutilisable et fait que chaque composent individuel soit plus simple à tester et a maintenir.

## Les Blueprints Principaux
### Le BP_Player
Dans le Player on y trouve les différent actions de base tel que le déplacement et la camera mais aussi la gestion de l'inventaire et l’apparition d’objet en main en fonction de la hotbar, l'initialisation du gestionnaire d'interaction et la fonction pour lancer des objets.

<img width="619" height="580" alt="United_Harvest - Unreal Editor 18_09_2026 14_02_14" src="https://github.com/user-attachments/assets/f8c93bee-1480-4c03-84ee-4a4c39e76746" />
<img width="1806" height="379" alt="United_Harvest - Unreal Editor 18_09_2026 14_02_07" src="https://github.com/user-attachments/assets/efb018f8-6411-4133-a62c-5e6254087e2a" />
<img width="1348" height="590" alt="United_Harvest - Unreal Editor 18_09_2026 14_01_59" src="https://github.com/user-attachments/assets/4cd07b07-9a73-45f8-8dd6-2a7eb8315174" />

### Objet interactif
Il y a deux type d'objets interactif ceux qui peut être dans l'inventaire et ceux qui ne le peuvent pas, que ce soit l'un ou l'autre il sont tous liée a l'interface d'interaction, BPI_Interact, mais ceux qui peuvent être dans l'inventaire sont tous des enfant du BP_BaseItem ont une variable contenant les infos de l'item qui est créer avec la structure S_ItemInfo.

<img width="1155" height="371" alt="United_Harvest - Unreal Editor 18_09_2026 14_08_55" src="https://github.com/user-attachments/assets/de855aab-d9d2-4794-9b6d-6d207583bac5" />
<img width="1105" height="612" alt="United_Harvest - Unreal Editor 18_09_2026 14_10_42" src="https://github.com/user-attachments/assets/9ac074b6-e466-42a2-8753-ef69dff0215d" />
<img width="1627" height="365" alt="United_Harvest - Unreal Editor 18_09_2026 14_10_32" src="https://github.com/user-attachments/assets/d27c6a19-75df-4704-acb8-f72006b9a0ef" />

### Inventaire 
L'inventaire est un composant rattacher au joueur qui permet de vérifier le statut des objets quand on essaye dans rajouter un. La gestion des objets s'effectue via a une data base qui contient les infos de tous les objets et deux enumerateurs pour l'Id des Objet et pour le type.

<img width="570" height="433" alt="United_Harvest - Unreal Editor 18_09_2026 14_20_41 (2)" src="https://github.com/user-attachments/assets/82c1d8ea-9290-4aa1-b29e-3a9bdcc735b1" />

### BP_InteractChecker 
Le gestionnaire d'interaction est une collision box qui suit une grille baser sur le joueur et vérifie si un objet doit réagir a un objet en main ou une simple interaction cela permettra d'avoir différent type d'interaction en fonction de la situation.

<img width="1289" height="542" alt="United_Harvest - Unreal Editor 18_09_2026 14_29_33" src="https://github.com/user-attachments/assets/17a11aad-e7ac-463a-801b-2b2f1d521a06" />

## Systeme d'interaction
```mermaid
graph TD;
Player-->Interaction;
Player-->Utilisation;
Interaction-->InteractChecker;
Utilisation-->InteractChecker;
InteractChecker-->ObjetInteractif;
ObjetInteractif-->ActionInteraction;
ObjetInteractif-->ActionUtilisation
```
## Système Physique
La seul fonction physique développer est le lancer d'objet fait avec un impulse. 

## Choix Technique Principaux

