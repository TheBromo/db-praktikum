# Setup Variants
1. You can use github codespaces
2. You can use Devcontainer (Vscode + Devcontainer Extension, Docker)
3. You can use your own installation (instsall psql tool or use something you want)

# How to run
Command to execute the script from within a terminal:

```bash
psql -h localhost -U postgres -d postgres -a -f nachname.sql
```
or if you have tasks isntalled

```bash
task script
```


