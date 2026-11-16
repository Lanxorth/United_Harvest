
# United Harvest : la plante de pomme de terre (5 stades de croissance)

**Objet présenté :** plant de pomme de terre, modélisé en 5 stades de croissance puis intégré dans Unreal Engine via MCP.

---

## 1. L'objet et son lien avec le GDD

United Harvest est un jeu d'aventure et de simulation de vie inspiré de *Rune Factory* et d'*Animal Crossing*. Le GDD (README du dépôt) met en avant la **collecte d'objets et de ressources** et la **boucle de gameplay** « trouver des ressources → rapporter les objets au village → développer le village ». La dimension ferme / vie quotidienne de *Rune Factory* passe par la culture de plantes.

Le plant de pomme de terre est la première **culture** du jeu :

- **Rôle gameplay :** le joueur plante, arrose et attend. La plante passe par 5 stades visibles, puis la patate se récolte à maturité. La récolte est une ressource à rapporter aux habitants pour répondre à leurs demandes.
- **Lien avec l'existant :** le projet contient déjà `BP_BaseSeed`, `BP_Hoe`, `BP_BaseFood` et `BP_TestInteractField`. Il s'appuie aussi sur l'interface `BPI_Interact` et la base `BP_BaseItem` (voir le Document_Technique). Le plant s'intègre dans cette chaîne graine → champ → nourriture.
- **Stades :** 1. Germe, 2. Jeune pousse, 3. Croissance, 4. Floraison, 5. Maturité.

---

## 2. Modélisation dans Blender (prompts + captures)

### 2.1 Prompt de départ

<img width="264" height="146" alt="Capture d&#39;écran 2026-11-16 202315" src="https://github.com/user-attachments/assets/c68c6aa6-66e5-48ec-b5cd-19e092909bc0" />

Contraintes données à l'IA : low poly, pas de butte de terre (le plant se pose directement sur le sol dans le jeu), base exactement à z = 0, et rapport de contrôle (noms, faces, dimensions) pour vérifier le résultat.

### 2.2 Création des 5 stades

<img width="322" height="446" alt="Capture d&#39;écran 2026-11-16 202324" src="https://github.com/user-attachments/assets/1a39f280-16db-44ad-b6bc-fc0ff0ef7ba4" />

Claude charge les outils Blender, puis crée les 5 stades dans la collection `Pommes_de_terre`. Chaque plant est un seul mesh low poly en flat shading, avec la base à z = 0 et sans butte.

### 2.3 Rapport de contrôle

<img width="320" height="470" alt="Capture d&#39;écran 2026-11-16 202337" src="https://github.com/user-attachments/assets/0a610861-763a-4cf8-be6b-b5893cf11285" />

| Objet | Faces | Tris | Dimensions X × Y × Z (m) |
|---|---|---|---|
| `Patate_Stade_1_Germe` | 24 | 38 | 0,20 × 0,16 × 0,22 |
| `Patate_Stade_2_Jeune_Pousse` | 62 | 90 | 0,39 × 0,22 × 0,48 |
| `Patate_Stade_3_Croissance` | 199 | 266 | 0,74 × 0,53 × 0,86 |
| `Patate_Stade_4_Floraison` | 386 | 508 | 1,02 × 0,86 × 1,00 |
| `Patate_Stade_5_Maturite` | 393 | 512 | 0,97 × 0,85 × 0,81 |

- **Stade 1 :** une courte tige avec 3 petites feuilles claires.
- **Stade 2 :** une tige avec 3 petites feuilles composées.
- **Stade 3 :** une tige principale et une tige secondaire, avec des feuilles composées en spirale.
- **Stade 4 :** 3 tiges, un feuillage dense et 3 fleurs blanches à cœur jaune.
- **Stade 5 :** des tiges brunes, des feuilles jaunies et affaissées, et 2 baies vertes.

Le budget reste faible : 24 à 393 faces par plant, 512 triangles au maximum. C'est cohérent avec un style low poly et plusieurs dizaines de plants à l'écran. Les plants sont espacés de 1,6 m sur l'axe X.

### 2.4 Rendu de contrôle dans Blender

<img width="338" height="569" alt="Capture d&#39;écran 2026-11-16 202301" src="https://github.com/user-attachments/assets/02ee5c58-4e86-4899-9ace-e32052b1d3fe" />

Vue de la scène Blender (capture avec l'outil `look`). On voit les stades alignés, du germe à la plante mature jaunie. Un rendu EEVEE à 16 échantillons a aussi été fait (caméra orthographique de face `Cam_Controle_Face`, soleil `Soleil_Controle`, fond gris-bleu neutre).

---

## 3. Intégration dans Unreal Engine via le MCP

<img width="251" height="50" alt="Capture d&#39;écran 2026-11-16 211412" src="https://github.com/user-attachments/assets/7b56c666-3325-4121-b55c-a5adbbbaabad" />


### 3.1 Le Blueprint `BP_Patate`

<img width="311" height="899" alt="Capture d&#39;écran 2026-11-16 211441" src="https://github.com/user-attachments/assets/fbab4178-ed16-4196-8c3d-ca2f5cb6db22" />

Un seul Blueprint, `BP_Patate`, contient les 5 stades. Chaque instance a **un seul composant visible**, ce qui permet de choisir le stade par instance. C'est le même principe que `BP_BaseItem` : un modèle commun, des variantes de données.

### 3.2 Prompt d'insertion dans la scène

<img width="323" height="381" alt="Capture d&#39;écran 2026-11-16 205002" src="https://github.com/user-attachments/assets/430a9799-32d6-443d-b509-4616f7528f63" />

Déroulé côté Unreal (MCP) :

1. La scène contient déjà des actors de test autour de x = 550–1400. Claude repère une zone libre, mesure la hauteur du sol par un tir de rayon, puis place les 5 instances de `BP_Patate`.
2. Les stades 2 à 5 n'affichent aucun composant visible : l'override d'instance n'a pas pris. Claude lit les noms des composants et teste `set_visibility`.
3. Les 5 instances sont en place, chacune avec le bon stade visible. Claude cadre la caméra de l'éditeur de face sur la rangée et prend le screenshot.

### 3.3 Vérification et sauvegarde

<img width="326" height="365" alt="Capture d&#39;écran 2026-11-16 205019" src="https://github.com/user-attachments/assets/d05165cc-3e8f-4bed-8d8a-f5baa855625d" />


Le premier screenshot de l'éditeur n'a produit aucun fichier. Claude relance avec une caméra de capture temporaire, supprimée ensuite. Il vérifie que les disques noirs au sol sont de simples icônes d'actors de l'éditeur. Il supprime la caméra de capture et sauvegarde le niveau. Les 5 stades sont placés dans `Lvl_OverworldMap` avec `BP_Patate`. De gauche à droite : germe, jeune pousse, croissance, floraison, maturité.

### 3.4 Détails de placement

<img width="328" height="300" alt="Capture d&#39;écran 2026-11-16 205025" src="https://github.com/user-attachments/assets/45a97e44-6ab2-4dfb-b880-b9f4c52e47ac" />

- Une ligne de 5 instances le long de l'axe Y (x = 1000), une instance tous les 130 cm.
- Elles sont à z = 50, la face supérieure du `SM_Cube` qui sert de sol.
- Les disques noirs au pied des plants sont les icônes d'actors de l'éditeur : ils n'apparaissent pas en jeu.
- Les premières instances spawnées pendant la recompilation du Blueprint avaient des composants mal nommés. Claude les a supprimées et recréées une fois. Le Blueprint était correct.

### 3.5 Résultat : les 5 stades dans le niveau

<img width="772" height="272" alt="Capture d&#39;écran 2026-11-16 204948" src="https://github.com/user-attachments/assets/229e9b07-866c-4310-b9d3-e4f2aa210a10" />

Capture finale dans `Lvl_OverworldMap` : les 5 plants sur le sol de test, du germe (gauche) à la maturité (droite). Le message rouge sur l'image est un avertissement de budget mémoire vidéo de l'éditeur.

---

## 4. Bilan et suite

- **Chaîne complète :** GDD → prompt Blender → 5 modèles low poly contrôlés (faces, dimensions) → `BP_Patate` → placement dans le niveau via le MCP Unreal → capture.
- **Limites rencontrées :** l'override de visibilité d'instance n'a pas pris, corrigé avec `set_visibility`. Le screenshot de l'éditeur a échoué, contourné avec une caméra temporaire.
- **Suite prévue :** faire dépendre le stade d'une variable de croissance (jours écoulés, arrosage), rendre la plante interactive via `BPI_Interact`, et faire donner une patate (`BP_BaseFood`) à la récolte.
