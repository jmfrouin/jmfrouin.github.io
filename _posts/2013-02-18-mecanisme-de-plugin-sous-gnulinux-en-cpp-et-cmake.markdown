---
layout: post
status: publish
published: true
title: Mécanisme de plugin sous GNU/Linux en C++ et CMake
author: Jean-Michel Frouin
author_login: jmfrouin
author_email: jm@frouin.me
author_url: http://frouin.me
date: '2013-02-18 19:12:19 +0100'
date_gmt: '2013-02-18 18:12:19 +0100'
categories:
- debian
- cmake
- home
- cpp
- embarque
tags: []
comments: []
---
<h2>Introduction</h2>
<p>Un système de plugin permet, à une application, de pouvoir charger de façon dynamique des ”bouts de code”.</p>
<!--more-->
<p>En fonction de l'implémentation du mécanisme de plugins, ces bouts de code peuvent être compilés (bibliothèque dynamique), pré-compilés (un objet java) ou même être lisibles directement par l'utilisateur, dans ce cas on parle de script (GIMP utilise, par exemple, le python pour certains de ces plugins).</p>
<p>Quelque soit la forme d’un plugin, sa fonction est toujours la même, apporter de nouvelles fonctionnalités à un programme.</p>
<p>Ce mécanisme permet donc de simplement rajouter des fonctionnalités à une application, en évitant, par exemple, de recompiler celle ci à chaque modification d’un petit bout de code.</p>
<p>Tout cela est bien beau mais ne semble pas répondre à des contraintes très strictes. Il peut arriver parfois que ce genre de mécanisme s'avère indispensable au fonctionnement d’une application.</p>
<p>Imaginons qu’une entreprise A développe une application pour une société B. A fournira l’application à B sous la forme d’un code machine dit binaire. Mais A ne fournira pas, sauf accord contraire, le code source à B. Dans ce cas un mécanisme de plugins est la seule solution pour permettre à B de faire évoluer les fonctionnalités de l’application (encore faut il que A implémente ce mécanisme, ce qui n’est pas dans son intérêt, qui fera donc en général partie du cahier des charges. Bien entendu, cela suppose que B ait songé à l’avenir de son application).</p>
<h2>Implémentation</h2>
<p>Dans le cas de Linux et d’une application écrite en C++, un plugin est une bibliothèque (dynamique ou statique) qui sera soit chargée à la demande (dans le cas des librairies dynamiques), soit inclue dans le code binaire de l’application (cas des bibliothèques statiques, mais dans ce cas là ce n'est plus un plugin mais une partie du code source de l'application).</p>
<p>Pour pouvoir charger une bibliothèque dynamique, il faut utiliser l’interface de programmation pour le chargeur de bibliothèques dynamiques (dlfcn.h) sous Linux.</p>
<p>Cette interface fournit 5 fonctions : dladdr, dlclose, dlerror, dlopen, dlsym, dlvsym. Le bout de code suivant remplit ce rôle (exemple tiré de man dlopen) :</p>
<p>Charger la bibliothèque mathématique et afficher le cosinus de 2,0 : (la gestion des erreurs a été retirée pour simplifier la compréhension)</p>
<pre class="brush:cpp">#include &lt;stdio.h&gt;
#include &lt;dlfcn.h&gt;

int main(int argc, char **argv) 
{
  void *handle;
  double (*cosine)(double);
  char *error;

  handle = dlopen ("libm.so", RTLD_LAZY); 
  //On charge la bibliotheque dynamique

  *(void **) (&amp;cosine) = dlsym(handle, "cos"); 
  //Appel d'une fonction de la bibliothèque

  printf ("%f\n", (*cosine)(2.0));
  dlclose(handle);
  return 0;
}</pre>
<p>Supposons que le programme s'appelle foo.c, on doit le compiler ainsi :<em>gcc -rdynamic -o foo foo.c -ldl</em></p>
<p>Une bibliothèque (disons malib.c) sera compilée ainsi <em>gcc -shared -nostartfiles -o malib malib.c</em></p>
<p>Cet exemple nous permet de voir comment l'on charge une bibliothèque dynamique. L'application utilisera exactement cette méthode pour charger les plugins.</p>
<p>Pour pouvoir utiliser des plugins, notre application va donc devoir charger des bibliothèques dynamiques. Pour simplifier, on regroupera tous les plugins dans un même répertoire.</p>
<p>Notre application possédera un objet plugin_manager dont le rôle sera de charger toutes les bibliothèques dynamiques se trouvant dans le répertoire <em>plugins</em> au démarrage. Cet objet construira une liste des plugins disponibles pour simplifier leur manipulation.</p>
<p>Il reste un problème un peu délicat à résoudre. Étant donné que l'on développe en C++, le plugin ne sera pas qu'une simple bibliothèque de fonctions, que l'on pourrait appeler avec <em>dlsym</em>, mais plutôt la définition d'un objet et de ses méthodes. Le problème est donc de trouver un moyen de créer une instance de ces objets lors du chargement des plugins.</p>
<p>Pour cela on utilise le fait que, lors du chargement d'une bibliothèque dynamique par <em>dlopen</em>, les variables globales se voient initialisées automatiquement.</p>
<p>Aussi chaque plugin, déclarera une variable globale, qui sera instancié au chargement :</p>
<pre class="brush:cpp">#include &lt;iostream&gt;

#include &lt;plugin_factory_initializer.h&gt; 
#include "plugin1.h"

namespace Plugin
{
  class Plugin1Factory : public PluginFactory
  {

  };

  PluginFactoryInitializer plugin1FactoryInitializer;
} // namespace Plugin</pre>
<p>Cette variable repose sur un template, PluginFactoryInitializer, pour enregistrer chaque plugin :</p>
<pre class="brush:cpp">#ifndef _PLUGIN_FACTORY_INITIALIZER_H_
#define _PLUGIN_FACTORY_INITIALIZER_H_

//STL
#include &lt;iostream&gt;
#include &lt;string&gt;

#include "plugin_factory_manager.h"

namespace Plugin
{
  template &lt;typename T&gt;
  class PluginFactoryInitializer
  {
    public:
    PluginFactoryInitializer()
    {
      T* factory = new T();
      PluginFactoryManager::instance()-&gt;factories[factory-&gt;getName()] = factory;
      std::cout << "Plugins: " << factory-&gt;getName() << " registered\n";
    }
  };
} 	//namespace Plugin
#endif 	//_PLUGIN_FACTORY_INITIALIZER_H_</pre>
<p>L'utilisation d'un <strong>std::map&lt;std::string, iplugin*&gt;</strong> permet d'avoir une table de hashage indexée sur le nom du plugin possédant un pointeur sur l'objet initialisé lors du chargement des plugins. Par la suite, en supposant que la table de hashage se nomme m_plugins, on accédera à l'objet d'écrit dans le plugin1 par : <strong>m_plugins["plugin1"]</strong>.</p>
<h2>Compilation modulaire</h2>
<p>Un autre problème est un peu délicat à résoudre: le fait de permettre de compiler l'application et ses plugins :</p>
<p>- En un gros binaire monolytique.<br />
- En un binaire et ses plugins (plusieurs bibliothèques dynamiques).<br />
- Un mix entre les deux (On inclut dans le binaire de l'application tel ou tel plugin, et les autres en bibliothèques dynamiques).</p>
<p>Sans modification du code source des plugins bien entendu.</p>
<p>Cette fonctionnalité, prend tout son sens lorsqu'elle est envisagée dans un cadre commercial.</p>
<p>En fait on va obtenir cet effet d'une façon détournée. Quand on voudra compiler un plugin dynamiquement on fera comme avant. C'est uniquement dans le cas d'un lien statique, avec le plugin, que l'on va redéfinir le comportement de l'outil de compilation.</p>
<p>Supposons que notre application possède deux plugins : <em>plugin1</em> et <em>plugin2</em>.</p>
<p>On commence par définir un fichier qui contiendra les informations de compilation des plugins :</p>
<pre class="brush:bash"># 0 = Compilation dynamique du plugin
# 1 = Compilation statique du plugin

SET(PLUGIN1 0) #On definie (au sens cmake) une variable PLUGIN1 valant 0.
SET(PLUGIN2 0)</pre>
<p>Dans cette configuration, l'application n'intégrera aucun plugin, et la compilation produira 2 plugins sous forme de bibliothèque dynamique.</p>
<p>On enregistre ce fichier dans <em>plugins.cmake</em> que l'on place à côté du <em>CMakeLists.txt</em> principal.</p>
<p>Maintenant il faut modifier le <em>CMakeLists.txt</em> principal pour qu'il intègre ce fichier, on lui ajoute donc :</p>
<pre class="brush:bash">INCLUDE(plugins.cmake)</pre>
<p>Grâce à cette directive, <strong>cmake</strong> a maintenant conscience de ce que l'on veut faire avec chaque plugin. Il reste à lui expliquer comment le faire :</p>
<pre class="brush:bash">##############################################################
#Gestion de la compilation dynamique ou statique des plugins
##############################################################
IF(${PLUGIN1} EQUAL 1)
AUX_SOURCE_DIRECTORY(plugins/plugin1 plugin1_src)
SET(projet_src ${projet_src} ${plugin1_src})
ENDIF(${GREEFON1} EQUAL 1)

IF(${PLUGIN2} EQUAL 1)
AUX_SOURCE_DIRECTORY(plugins/plugin2 plugin2_src)
SET(projet_src ${project_src} ${plugin2_src})
ENDIF(${PLUGIN2} EQUAL 1)
#############################################################</pre>
<p>Explications : \\</p>
<p>Si un plugin doit être compilé en statique, sa variable associée dans le fichier plugins.cmake vaudra 1. Dans ce cas, on entre dans le IF. A ce moment là, la directive <em>AUX_SOURCE_DIRECTORY</em> ajoute la liste des fichiers sources du plugin <strong>plugin_src</strong> (défini dans le CMakeLists.txt du plugin) comme source additionnelle de l'application. Le <strong>SET</strong> qui suit permet de dire à cmake que les fichiers du plugins font partie du code source du binaire principal. On a ainsi compilé le plugin en statique avec le binaire de notre application.</p>
<p>Mais puisque l'on a rien modifié d'autre on risque d'avoir aussi une bibliothèque dynamique qui va être générée. Il reste à corriger cela.</p>
<p>En fait, nous allons simplement utiliser l'ancien comportement quand la variable vaut 1, sinon on ne fera rien (puisque le problème est résolu dans le CMakeLists.txt principal).</p>
<p>Voyons comment se présente le CMakeLists.txt de plugin1 :</p>
<pre class="brush:bash">set(plugin1_src plugin1.cpp)

IF(${GREEFON1} EQUAL 1)
MESSAGE(STATUS "plugin1 : STATIC")
ELSE(${GREEFON1} EQUAL 1)
ADD_LIBRARY(plugin1 SHARED ${plugin1_src})
TARGET_LINK_LIBRARIES(plugin1plugin manager directory nl)
MESSAGE(STATUS "plugin1 : DYNAMIC")
ENDIF(${GREEFON1} EQUAL 1)</pre>
<p>L'application peut maintenant compiler dans n'importe quel mode à condition de bien renseigner le fichier <em>plugins.cmake</em>.</p>
<h2>Références</h2>
<p><a href="http://www.isotton.com/devel/docs/C++-dlopen-mini-HOWTO/C++-dlopen-mini-HOWTO.html" target="">C++ dlopen mini HOWTO</a><br />
<a href="http://www.faqs.org/docs/Linux-HOWTO/Program-Library-HOWTO.html#DL-LIBRARIES" target="">Dynamically Loaded (DL) Libraries</a></p>
<h2>Historique</h2>
<p>Version 1.00, Septembre 2007 : Création du document<br />
Version 1.01, Aout 2011 : s/plugin/plugin/<br />
Version 1.10, Septembre 2011 : Mise en ligne du document en PDF<br />
Version 1.20, Février 2013 : Mise en ligne du document en HTML</p>
<!-- Matomo -->
<script type="text/javascript">
  var _paq = window._paq || [];
  /* tracker methods like "setCustomDimension" should be called before "trackPageView" */
  _paq.push(['trackPageView']);
  _paq.push(['enableLinkTracking']);
  (function() {
    var u="//stats.frouin.me/";
    _paq.push(['setTrackerUrl', u+'matomo.php']);
    _paq.push(['setSiteId', '1']);
    var d=document, g=d.createElement('script'), s=d.getElementsByTagName('script')[0];
    g.type='text/javascript'; g.async=true; g.defer=true; g.src=u+'matomo.js'; s.parentNode.insertBefore(g,s);
  })();
</script>
<!-- End Matomo Code -->
