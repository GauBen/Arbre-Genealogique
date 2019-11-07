# Arbre-Genealogique
Système de gestion d'arbres généalogiques en ADA

## Liste d'outils pour coder en ADA sur windows
Ouvrir un PowerShell en mode administrateur puis tapper :
```console
Set-ExecutionPolicy Bypass -Scope Process -Force
iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
```

Maintenant on peut installer plein de programmes :
```console
choco install gnat-gpl -y
choco install vscode -y
choco install git.install --params "/NoGuiHereIntegration /NoShellHereIntegration" -y
choco install svn -y
```

Ensuite, plein de modules pour VSCode (barre de droite, les quatre carrés) :
* ADA par Entomy
* Bearded Theme par BeardedBear
* EditorConfig for VS Code par EditorConfig
* file-icons par file-icons
* Git par Don Jayamanne
* SVN par Chris Johnston (pas indispensable)
* Visual Studio IntelliCode par Microsoft
* ...

Enfin, se placer dans le dossier qui contiendra le projet et le cloner :
```console
git clone https://github.com/GauBen/Arbre-Genealogique.git
cd Arbre-Genealogique
code .
```

Et maintenant, au boulot !

## Tips
* Découvrir VSCode : [User Interface](https://code.visualstudio.com/docs/getstarted/userinterface), [Visual Studio Code Tips and Tricks](https://code.visualstudio.com/docs/getstarted/tips-and-tricks)
* Faire des messages de commit utiles : [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0-beta.4/)
* Compiler le fichier de code ouvert : `Ctrl+Shit+B`
* Chercher une commande : `Ctrl+Shit+P`
* Nettoyer le dossier ou formater le code : `Ctrl+Shit+P` > Run Task > ...
* Ouvrir les paramètres : `Ctrl+,`
* ...
