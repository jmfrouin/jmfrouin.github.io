---
layout: post
status: publish
published: true
title: Convention de code en C++
author: Jean-Michel Frouin
author_login: jmfrouin
author_email: jm@frouin.me
author_url: http://frouin.me
date: '2013-02-22 18:55:14 +0100'
date_gmt: '2013-02-22 17:55:14 +0100'
categories:
- cpp
tags: []
comments: []
---
<h2>Introduction</h2>
<p>A partir du moment où l'on développe du code, que ce soit seul ou en équipe, il faut quelques conventions pour rendre le code "compréhensible". Un premier réflexe à avoir est de bien commenter le code. Soit pour les autres développeurs, soit pour les autres personnes intervenant dans le projet et qui seront amenées à lire le code. Pour ce faire, il faut dès le départ avoir une convention de nommage. Une convention de nommage est un ensemble de règles de mise en forme du code. Un très bon ouvrage (<a href="http://www.programmingresearch.com" target="_blank">High-integrity C++ coding standard manual</a>) traite des lignes de conduites conseillées pour coder en C++. Dans le cas de ce document, elles ne s'appliquent pas toutes. Toutes les conventions, ou lignes de conduites, ne sont fournies qu'à titre informatif.</p>
<!--more-->
<h2>Nommage</h2>
<p>Une convention de nommage est essentielle, si on veut gagner du temps, aussi bien pour intégrer de nouveaux développeurs dans le projet, que pour débugger son code. Une chose est importante lorsque l'on trouve un nom pour une donnée membre (ou une variable) : il faut trouver un nom qui convient. Pour cela, il faut suivre la convention de nommage et en plus trouver un choix judicieux. Un nom ne doit pas être trop long ni trop court. Voici ma convention (mixte entre celle de Microsoft et celle du noyau linux).</p>
<p>Pour définir :</p>
<p>Variable globale : bool gVar<br />
Donnée membre d'une classe : bool mVar.<br />
Variable à portée locale : bool Var.<br />
Paramètre d'une méthode : void CClass::Function(bool var).<br />
Type : typedef char tVarType.<br />
Méthode privée d'une classe : bool CClass::__Register();<br />
Nom d'une classe : class CName.<br />
Interface de classe : class IName.<br />
Patrons (template) d'une classe : class TName.<br />
Enumération : enum eVarName.</p>
<h2>Code</h2>
<h3>Introduction</h3>
<p>D'une manière générale, il est important de bien commenter les fichiers d'en-têtes des classes. Une autre chose importante est de bien organiser le répertoire du projet dès le début. Il faudra veiller à prévoir un répertoire pour la compilation séparée du répertoire contenant les sources (voir cmake) Isoler les codes sources dans un répertoire dédié.</p>
<pre class="brush:shell">+-build (Répertoire de compilation totalement)
+-doc (Contient la documentation doxygen)
+-gfx (Images pour doxygen)
+-src (Contient tous les codes sources du projet)
+---- leaks
+---- plugins
+---- outils
+---- xml</pre>
<p>Pour le développement de logiciels libres, certains fichiers doivent être présents. C'est une bonne méthode de travail de les intégrer par défaut dans n'importe quel projet.</p>
<p>Notamment :</p>
<p>COPYING : Contient la licence du projet.<br />
CHANGELOG : Contient la liste des modifications. (Très pratique pour garder une trace des évolutions du projet)<br />
COPYRIGHT : Contient la liste des auteurs qui ont participé au projet.<br />
INSTALL : Contient une description complète sur la façon de compiler et d'installer l'application.<br />
README : Contient des informations générales sur le projet.<br />
TODO : Liste des tâches à faire.</p>
<p>Bien entendu, le contenu de ces fichiers peut facilement être intégré dans la documentation, doxygen par exemple, du projet.</p>
<h3>Accesseurs et mutateurs</h3>
<p>Plutôt que de rendre une donnée membre public ou protected, il vaut mieux utiliser les accesseurs / mutateurs pour y accéder.<br />
Un accesseur n'est rien d'autre qu'une méthode de la classe permettant de récupérer la valeur de la donnée membre. Le type de retour de l'accesseur est donc celui de la donnée membre à encapsuler.<br />
Un mutateur est une méthode de la classe permettant de modifier la valeur de la donnée membre. Le type de retour du mutateur est donc void. Par contre, le mutateur prend au moins une valeur en paramètre, la nouvelle valeur.</p>
<pre class="brush:cpp">
code/acc_mut.cpp
</pre>
<p>Lorsque toutes les données membres d'une classe sont totalement encapsulées par un couple accesseur / mutateur, on parle de programmation objet pure. (C++ n'oblige pas la POO pure)</p>
<h3>Accolades</h3>
<p>On a vite tendance à écrire ce genre de choses :</p>
<pre class="brush:cpp">
bool Classe::Verif()
{
if(condition)
  return true;
else
  return false;
}
</pre>
<p>Pour que le code soit plus lisible (et plus fonctionnel), j'utilise les accolades autant que possible.</p>
<p>Le code devient donc :</p>
<pre class="brush:cpp">
bool Classe::Verif()
{
  if(condition)
  {
    return true;
  }else
  {
    return false;
  }
}
</pre>
<p>L'utilisation des accolades peut sembler inutile ici, mais en fait si l'on vient à commenter un des return, les accolades nous évitent les erreurs de compilation.</p>
<p>Ainsi le code suivant compilera toujours (ce qui n'est pas le cas du même code sans accolades) :</p>
<pre class="brush:cpp">
bool Classe::Verif()
{
  if(condition)
  {
    //return true;
  }
  else
  {
    return false;
  }
}
</pre>
<h3>Classe</h3>
<h4>Écriture</h4>
<p>Lors de l'écriture d'une classe, déclarer les méthodes et les données membres séparément pour plus de clarté. Utiliser l'opérateur de portée pour les séparer. Ainsi, au lieu de :</p>
<pre class="brush:cpp">
class CClasse
{
  public:
    void Methode1();
    int mNb;
    void Methode2();
    int mLong;
    int mLarg;
};
</pre>
<p>On préférera :</p>
<pre class="brush:cpp">
class CClasse
{
  //Méthodes.
  public:
    void Methode1();
    void Methode2();

  //Données membres.
  public:
    int mNb;
    int mLong;
    int mLarg;
};
</pre>
<p>De plus, il est important (pour une efficacité plus grande lors d'une recherche) de définir les méthodes dans l'ordre décroissant de leur portée. (public -> protected -> private).</p>
<pre class="brush:cpp">
classe CClasse
{
  public:
    CClasse();

  protected:
    Methode();

  private:
    ~CClasse();
};
</pre>
<h4>Implémentation</h4>
<p><em>Forme de Coplien sécurisée</em> :</p>
<p>Lors de l'écriture de classe complexe (notamment gérant des pointeurs), on peut réduire les risques de problèmes en définissant :<br />
Un constructeur par défaut.<br />
Un constructeur par copie.<br />
Un opérateur de copie par affectation (T& operator=(const T&;)).<br />
Un destructeur (Si ces 4 méthodes sont correctement implémentées, on parle alors de forme de Coplien (sécurisée)).</p>
<p><em>Limiter le nombre de paramètres d'une méthode / fonction</em> :</p>
<p>Pour améliorer la lisibilité et la performance du code, ne pas définir plus de 6 à 8 paramètres pour une fonction/méthode. (Si on a besoin de plus de 6 paramètres, il faut se demander si la méthode est bien conçue)</p>
<p><em>Définir les tests explicitement</em> :</p>
<p>Une autre petite habitude à prendre, qui simplifie la vie (et évite de revenir sur des dizaines de fichiers plus tard) est de toujours définir les tests explicitement :</p>
<pre class="brush:cpp">
if(mVar != 0)
</pre>
<p>plutôt que</p>
<pre class="brush:cpp">
if(mVar)
</pre>
<p>En effet, Si mVar est un pointeur, cela fonctionnera. Mais si, du jour au lendemain, le pointeur devient un scope pointeur, alors il faudra revenir sur le code.</p>
<p>\textit{Initialiser ses pointeurs} :</p>
<p>Encore une bonne habitude à prendre (qui découle de la remarque précédente) : toujours initialiser les pointeurs à 0 dans les constructeurs par défaut d'une classe.</p>
<p>Cela permet de détecter rapidement les problèmes (en supposant que l'on utilise des tests explicites).</p>
<p>Les deux remarques précédentes évitent le problème illustré par le code suivant :</p>
<pre class="brush:cpp">
#include

int main()
{
  int* Ptr;
  if(Ptr)
  {
    std::cout &lt;&lt; "Que ce passe t'il si j'utilise Ptr ici ?\n";
  }
  return EXIT_SUCCESS;
}
</pre>
<p><em>Mots clefs à éviter</em> :</p>
<p>Ne <strong>JAMAIS</strong> utiliser goto. Éviter au maximum l'utilisation de <strong>const</strong> qui peut être trop facilement annulé grâce à <strong>mutable</strong>.</p>
<h3>Constantes et Variables globales</h3>
<p>Éviter au maximum d'utiliser des nombres importants (pour le projet) sans explication. Par exemple, pour l'utilisation d'un masque de bit : 0xFF00, il vaut mieux passer par une constante : <em>#define masque 0xFF00;</em>. De plus suffixer les constantes par un F pour un flot, un L pour un long: <em>#define max = 122.0L</em> simplifie la lecture du code.</p>
<p>L'utilisation de variables globales est déconseillée, car cela rend le code non portable (cf C++ Gotchas: Avoiding Common Problems in Coding and Design, Gotchas \#3).</p>
<p>L'utilisation de <em>NULL</em> pour initialiser un pointeur à 0 n'est pas pertinente car <em>NULL</em> est en fait une définition dépendante de la machine sur laquelle on compile le code. L'utilisation de NULL rend donc le code plus difficile à porter, mais est surtout source d'erreur.</p>
<p>Exemple de différentes définitions de NULL :</p>
<pre class="brush:cpp">
#define NULL ((char *)0)
#define NULL ((void *)0)
#define NULL 0
</pre>
<h3>Fonctions inline</h3>
<p>Les fonctions inline doivent être des fonctions courtes (Les accesseurs et les mutateurs sont de bons candidats aux fonctions inline) sans quoi cela peut affecter les performances.</p>
<p>Il vaut mieux définir une fonction inline de façon implicite. Ainsi vaut-il mieux écrire cela :</p>
<pre class="brush:cpp">
classe CClasse
{
  public:
  //Déclaration, inline, implicite car définie dans la déclaration de la classe.
  int getNb() { return mNb; }

  private:
    int mNb;
};
</pre>
<p>au lieu de :</p>
<pre class="brush:cpp">
classe CClasse
{
  public:
    inline int getNb(); //Déclaration explicite (mot clef inline)

  public:
    int mNb;
};

CClasse::getNb()
{
  return mNb; // Définition hors de la déclaration de la classe.
}
</pre>
<h3>Initialisation</h3>
<p>Il est préférable d'initialiser directement une variable lors de sa création plutôt que de lui affecter une valeur après sa création. Ainsi :</p>
<pre class="brush:cpp">
std::string Tmp("Test");
</pre>
<p>est préférable à :</p>
<pre class="brush:cpp">
std::string Tmp;
Tmp = "Test";
</pre>
<p>Dans le premier cas, seul le constructeur (Attention, le constructeur de std::string (comme beaucoup de classes) ne se limite pas à l'appel du constructeur de std::string, mais par exemple à l'appel des constructeurs de ses classes parentes} de std::string est appelé.<br />
Dans le second on ajoute une opération d'affectation via l'opérateur = des std::string.</p>
<h3>Instruction de branchement</h3>
<p>Pour éviter les calculs inutiles, il vaut mieux ne pas faire appel à une méthode dans le test d'arrêt d'une instruction de branchement.</p>
<p>Ce code fera appel à la méthode getMax, de l'objet <em>a</em>, autant de fois qu'il y aura d'itération :</p>
<pre class="brush:cpp">
for(int i = 0; i &lt; a.getMax(); ++i)
...
</pre>
<p>Ce code n'appellera getMax qu'une fois :</p>
<pre class="brush:cpp">
const inst Max = a.getMax();
for(int i=0; i &lt; Max; ++i)
...
</pre>
<h3>Retour</h3>
<p>L'utilisation classique des <strong>return</strong> ne permet pas de garder la maîtrise d'une méthode. En effet on ne sait jamais à l'avance où sortira (dans le code) notre fonction:</p>
<pre class="brush:cpp">
bool Classe::Verif()
{
  if(condition)
  {
    return true; //On sort ici ?
  }
  else
  {
    return false; //Ou la ?
  }
}
</pre>
<p>Cela peut être amélioré avec :</p>
<pre class="brush:cpp">
bool Classe::Verif()
{
  bool Ret = false;
  if(condition)
  {
    Ret = true;
  }
  return Ret; //On sort toujours ici !
}
</pre>
<p>Pfffff voila ! </p>
