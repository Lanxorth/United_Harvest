# Architecture cible

Utilisateur → UE Lead → Architecte → (C++ / Blueprint) → Reviewer indépendant → QA → Documentation → rapport et validation humaine.

- L'architecte inspecte et propose avant les changements.
- Le reviewer examine le diff sans modifier les fichiers.
- QA compile et teste; un build réussi ne garantit pas le comportement fonctionnel.
- Les changements d'assets doivent être limités, réversibles et compilés.
- Le plugin fourni est un squelette Editor uniquement : aucun serveur MCP ni édition Blueprint n'est encore implémenté.
