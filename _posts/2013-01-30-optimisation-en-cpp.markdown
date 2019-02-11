---
layout: post
status: publish
published: true
title: Optimisation en C++
author: Jean-Michel Frouin
author_login: jmfrouin
author_email: jm@frouin.me
author_url: http://frouin.me
date: '2013-01-30 19:43:47 +0100'
date_gmt: '2013-01-30 18:43:47 +0100'
categories:
- cpp
- home
tags: []
comments:
- id: 630
  author: Alip
  author_email: racinecubique_ma@hotmail.fr
  author_url: ''
  date: '2014-02-21 22:17:57 +0100'
  date_gmt: '2014-02-21 21:17:57 +0100'
  content: Merci pour cet article ! Une mine d'or pour tout programmeur en herbe.
---
<h2>Règles d’optimisations générales</h2>
<p>Fréquemment, les programmeurs ont tendance à trop se reposer sur le compilateur. Malgré le fait que les compilateurs actuels soient assez performant niveau optimisation, ils restent quand même des automates obéissant à des règles préétablies, et ne seront jamais aussi performants que l’homme.</p>
<!--more-->
<p>Ayant une longue expérience du code généré par les compilateurs, j’ai tendance à « surveiller » le résultat compilé et à remanier mon code si je vois que le compilateur n’a pas fait très fort sur telle ou telle partie du code.<br />
Mais sans aller jusque là, voici quelques bases à respecter pour éviter que le compilateur ne fasse trop de bêtises</p>
<h3>Code lisible vs. Optimisations</h3>
<p>On croit souvent, à tort, qu’un code optimisé perd forcément en lisibilité. Si c’est souvent le cas en assembleur, en C/C++ un code optimisé est fréquemment un code plus simple et plus facile à lire.</p>
<h4>Des fonctions simples</h4>
<p>Essayez de faire des fonctions simples, avec 5 à 8 variables « en jeu » et le moins de paramètres possible. Une surcharge de variable amène le compilateur à recharger ses registres constamment, et augmente fortement les accès mémoire.<br />
Cette règle est encore plus importante dans les boucles. N’hésitez pas à découper une boucle complexe en plusieurs boucles simples. La perte engendrée par les multiples parcours est largement récupérée par la simplicité du code généré.</p>
<h4>Les processeurs x86 favorisent les données 32bit</h4>
<p>Utiliser au maximum des données 32bit (int, long, etc…). Les données type byte ou char sont aussi traitées de manière native par le processeur. Par contre, éviter les données 16bit. Depuis le passage en 32bit des processeurs intel, les données 16bit sont plus lentes (opcodes supplémentaires). Les compilateurs ont tendance à les transformer en 32bit lors des traitements, mais génèrent du code en plus pour effacer ou étendre le signe. Idem pour les tableaux de données 16bit : On pourrait croire qu’en réduisant la mémoire à traiter, on gagne en vitesse, mais c’est faut. Il faut le même temps pour lire 16 ou 32bits en mémoire.<br />
Par dessus tout, éviter les mélanges de types. L’affectation d’un type long à un type court ne génère pas de code supplémentaire, mais le contraire oui.</p>
<p>Ainsi,</p>
<pre class="brush:cpp">S32 Tableau[1000] ;
for(S16 i=0 ; i&lt;1000; i++) Tableau[i]:=i;</pre>
<p>est environ deux fois plus lent que</p>
<pre class="brush:cpp">int Tableau[1000] ;
for(S32 i=0 ; i&lt;1000; i++) Tableau[i]:=i;</pre>
<h4>Favoriser les variables locales:</h4>
<p>Les variables locales sont parfaitement optimisables par le compilateur, alors que les variables globales le sont beaucoup moins, surtout dans un environnement qui peut être multi-thread.<br />
Une variable locale pourra être optimisée dans un registre CPU, alors qu’une variable globale ne le sera quasiment jamais. Cette règle est particulièrement vraie pour les tableaux ou les classes/structures<br />
Dans bien des cas, il est plus efficace d’affecter un tableau global à un alias local :</p>
<pre class="brush:cpp">int Tableau[1000] ;
void func(void)
{
  int *local=Tableau;
  for(int i=0; i&lt;1000; i++) local[i]=i;
}</pre>
<h4>Conventions d’appel de fonction</h4>
<p>La convention d’appel des fonctions détermine la façon dont le compilateur va passer les paramètres à une fonction.<br />
La convention d’appel par défaut est _cdecl, convention standard de C/C++. Tous les paramètres sont passés sur la pile.<br />
La convention _fastcall, héritée du pascal force le passage des 4 premiers paramètres dans les registres processeur, le reste dans la pile. Cette convention est nettement plus efficace, particulièrement pour les petites fonctions avec peu de paramètres. Le compilateur « sait » qu’il ne doit pas sauvegarder l’état des registres utilisés, il ne génère pas de cadre de pile et il n’y a pas d’accès mémoires.<br />
On peut forcer le _fastcall dans les paramètres du compilateur, mais il faut alors faire attention aux pointeurs de fonctions qui devront l’implémenter explicitement.<br />
Sinon, vous pouvez forcer cette convention sur une fonction avec :</p>
<pre class="brush:cpp">void _fastcall func(void) …</pre>
<h4>Fonctions "inline"</h4>
<p>Dans la mesure du possible, le compilateur essaye de « dérouler » les petites fonctions dans les fonctions qui les appellent, évitant ainsi de générer un appel et le code qui va avec.<br />
Le problème et que le compilateur décide seul de qui sera « inliné »et qui ne le sera pas, ce qui n’est pas toujours optimal.<br />
Vous pouvez forcer une fonction inline avec :</p>
<pre class="brush:cpp">inline void func(void)</pre>
<p>Pour un maximum d’efficacité, implémentez les petites fonctions de classe directement dans la déclaration de la classe, cela permet au compilateur de dérouler ces fonctions dans tous les modules qui les utilisent.</p>
<h4>Fonctions membres virtuelles</h4>
<p>Sauf dans le cas de classes polymorphiques, les fonctions virtuelles sont à bannir ! Les appels de ces fonctions génèrent 2 déréférencements et un appel indirect, alors qu’une fonction normale ne génère qu’un appel direct. Dans le cas de petites fonctions, cela peut doubler ou tripler les temps d’exécutions !</p>
<h4>Allocations mémoire</h4>
<p>Les programmes qui privilégient les allocations dynamiques ont souvent deux problèmes majeurs : D’abord, les tests de pointeurs NULL ne sont pas toujours fait, et lorsqu’ils sont gérés, on ne sait bien souvent jamais quoi faire, surtout lorsque l’allocation est dans une fonctions bas niveau. Puis, beaucoup d’allocations/libérations de mémoire a tendance à fragmenter la mémoire et rendre la tache du gestionnaire de mémoire de plus en plus lente et ardue.<br />
Si possible, favorisez plutôt les allocation statiques : les tableaux. D’abord parce que le système alloue toute la mémoire d’un coup pour tous les tableaux quand l’exécutable est chargé – pas de fragmentation – et on a pas à gérer les pointeur NULL.</p>
<p>Dans le cas de listes chaînées, si les éléments sont créés à la suite sans que d’autres allocations ne viennent s’intercaler, il est nettement plus efficace de faire un tableau dynamique (malloc) et de le faire grossir lors des ajouts (realloc).</p>
<h2>Optimisation du code</h2>
<p>Avant de commencer, je voudrais mettre l’accent sur les « saut ». La plupart d’entre eux sont tellement implicite qu’on n'a même pas conscience que le compilateur va les utiliser. Pourtant, toutes les structures de contrôle en génèrent.<br />
Malgré l’évolution des processeurs et les technologies actuelles, tous les processeurs ont une bête noire commune : les sauts. Les sauts engendrent des chargements/déchargements des caches, des ruptures de pipelines processeur et des ré-affectations de registres et de flags internes. Bref, c’est l’armaggedon des processeurs ! Et pourtant, nos programmes en sont pleins. Beaucoup des optimisations qui suivent sont faites pour minimiser les sauts et linéariser le code.</p>
<h4>Optimisation des boucles « for »</h4>
<p>Dans les cas ou l’indice de boucle n’est pas utilisé dans la boucle, une boucle pré-décrémentale et bien plus efficace qu’une boucle post-incrémentale :</p>
<pre class="brush:cpp">for(int i=0; i&lt;Count; i++) DoSomething();</pre>
<p>Peut-être optimise par:</p>
<pre class="brush:cpp">for(int i=Count+1; --i;) DoSomething();</pre>
<p>Cette boucle génère 2 instructions de moins et réorganise la boucle de façon linéaire.</p>
<p>Même dans certain cas ou l’indice est utilisé, il est plus efficace d’utiliser un autre index :</p>
<pre class="brush:cpp">for(int i=0; i&lt;Count; i++) Tableau[i]=GetNextValue() ;</pre>
<p>Peut être optimise par</p>
<pre class="brush:cpp">for(int i=Count+1,j=0; --i; j++) Tableau[j]=GetNextValue();</pre>
<p>Ou encore mieux</p>
<pre class="brush:cpp">for(int i=Count+1,*ptr=Tableau; --i; ptr++) *ptr=GetNextValue();</pre>
<h4>Eliminer les conditions dans les boucles</h4>
<p>Les boucles doivent être le plus linéaire possible. Il faut penser à sortir le maximum de condition à l’extérieur de la boucle ou à réunir plusieurs condition en une :</p>
<pre class="brush:cpp">for(i=0; i&lt;1000; i++)
{
  i&lt;500?DoAction1():DoAction2();
}</pre>
<p>peut-être réorganisé en:</p>
<pre class="brush:cpp">for(i=501; --i;) DoAction1();
for(i=501; --i;) DoAction2();</pre>
<p>Cherchez à éliminer les cas particuliers :</p>
<pre class="brush:cpp">for(i=0; i&lt;Count; i++)
{
  !i?GetFirstElement():GetNextElement();
}</pre>
<p>devient :</p>
<pre class="brush:cpp">GetFirstElement() ;
for(i=Count+1-1 /*voir plus haut pour comprendre*/; --i;) GetNextElement();</pre>
<h4>Tirer avantage des instructions return, break et continue</h4>
<p>L’automate d’optimisation du compilateur est réellement efficace sur des flux de code courts et linéaires. L’instruction goto perturbe la continuité du flux et permet de sauter n’importe ou. Dans de tels cas, le compilateur doit prendre en compte la rupture du code et se protége en diminuant les optimisations sur les variables.<br />
Les instructions return, break et continue, utilisées dans les corps des fonctions sont souvent considérées, à tort, comme une « mauvaise programmation ». Pourtant dans ces cas la, le compilateur connaît parfaitement leurs bornes d’action et n’a très souvent pas besoin de protéger l’intégrité du code.<br />
Utilisées aux bons endroits, elles évitent avantageusement l’utilisation de booléen ou autres variables pour contrôler le flux, réduisent les tests dans les boucles, et rendent souvent le code moins complexe.</p>
<h4>Limiter l’utilisation des flottants et des integers large (48, 64bits, …)</h4>
<p>Malgré les FPU de plus en plus rapides et performantes, les flottant restent bien plus lents que les types entiers. De plus, n’utilisez que le type « double », seul type à être interprété de façon native par les FPU. Attention aussi à limiter les conversions entiers/flottants et vice-versa, les instructions FPU de conversion sont très lentes.<br />
Les type long de type int64 sont à éviter aussi. N’étant pas traités de façon native, les algorithmes qui les gèrent sont assez lents…</p>
<p>Pour info, voici les temps d’exécutions de diverses opérations en entiers, en entiers 64bits, et en flottants :</p>
<p>Addition : Int 1s, Int64 2.6s, Double 1.3s<br />
Multiplication : Int 1.6s, Int64 26.2s, Double 3.1s<br />
Division : Int : 4.7s, Int64 804s, Double 35.8s<br />
Les temps indiqués sont la moyenne des résultats obtenus avec plusieurs valeurs aléatoires.</p>
<h4>Limiter les multiplications, éviter les divisions, préférer les puissances de 2</h4>
<p>Depuis le Pentium II, les multiplications sont rapides, mais les ressources processeur qu’elles utilisent nuisent à d’autres optimisations.<br />
Pour des traitements entiers, il vaut mieux privilégier les décalages/additions quand c’est possible :</p>
<pre class="brush:cpp">int a=b*2;</pre>
<p>sera optimisé par le compilateur en</p>
<pre class="brush:cpp">int a=b&lt;&lt;1;</pre>
<p>ou</p>
<pre class="brush:cpp">int a=b+b;</pre>
<p>Une addition ou un décalage sera toujours plus rapide et plus facile à traiter par le processeur.</p>
<p>Par contre :</p>
<pre class="brush:cpp">int a=b*17;</pre>
<p>ne sera pas optimisé par le compilateur et restera une multiplication.</p>
<p>Alors que :</p>
<pre class="brush:cpp">int a=(b&lt;&lt;4)+b;</pre>
<p>est bien meilleur même si cela génère deux instructions au lieu d’une. Quant aux divisions, comme le montre le tableau du dessus, c’est le carnage total. Pour les entiers et lorsque c’est possible, essayez de les remplacer par des décalages. Sinon, si les valeurs à diviser ne sont pas grandes et que le diviseur est constant, voici une astuce :</p>
<pre class="brush:cpp">int a=b/37;</pre>
<p>Devient</p>
<pre class="brush:cpp">int a=(b*(0x10000/37/*valeur constante*/))&gt;&gt;16;</pre>
<p>Pour les divisions de flottants, utilisez plutôt la multiplication par l’inverse :</p>
<pre class="brush:cpp">void DivArray(double *Array, double Divider, int Count)
{
  for(int I=Count+1;--I;Array++) *Array/=Divider;
}</pre>
<p>est bien plus lent que:</p>
<pre class="brush:cpp">void DivArray(double *Array, double Divider, int Count)
{
  double Inverse=1/Divider;
  for(int I=Count+1;--I;Array++) *Array*=Inverse;
}</pre>
<h2>Optimisations poussées</h2>
<p>Ces optimisations sont généralement moins importantes et leur implémentation est souvent moins visible. Mais n’oublions pas que les petits ruisseaux font les grandes rivières. De plus, dans des situations répétitives sur des gros volumes, elles peuvent être redoutablement efficaces.<br />
Et il ne coûte souvent pas grand chose d’y réfléchir 5 secondes .</p>
<h4>Favoriser les chemins directs par défaut dans les tests</h4>
<p>Pour éviter le maximum de saut, il faut essayer de faire passer les cas généraux dans les « then » et les cas particuliers – ceux qui seront vrais moins souvent - dans les « else ».<br />
Ainsi,</p>
<pre class="brush:cpp">CasParticulier?DoParticularAction():else DoGeneralAction();</pre>
<p>Devrait devenir</p>
<pre class="brush:cpp">(!CasParticulier)?DoGeneralAction():DoParticularAction();</pre>
<p>Le mécanisme de prédiction de branchement du processeur ne s’active qu’au premier branchement effectif. En limitant les branchements, on limite les ruptures inutiles des pipelines processeur.</p>
<h4>Utiliser des variables temporaires locales pour les pointeurs</h4>
<p>L’utilisation de variable temporaire dans des boucles permet de forcer le chargement en registre des valeurs. Ceci est particulièrement vrai pour les pointeurs et les références de tableau:</p>
<pre class="brush:cpp">If (NeedCopy)
{
  for(int i=1001;--i;) DataCopy[i]=myClass.Data[i] ;
}</pre>
<p>Deviendra :</p>
<pre class="brush:cpp">If (NeedCopy)
{
  int *tmp=myClass.Data;
  for(int i=1001;--i;) DataCopy[i]=tmp[i];
}</pre>
<h4>Aligner les données</h4>
<p>Le compilateur aligne automatiquement le maximum de données sur des adresses divisible par 4. En effet la lecture ou l’écriture d’adresses non alignées est 2 fois plus lente. Les allocations mémoires sont automatiquement alignées sur 16 et donc ne posent pas de problèmes, sauf si on réalise des opérations « à la main », comme par exemple :</p>
<pre class="brush:cpp">char *mem=(char)malloc(1+sizeof(int)*nombre_de_long);
int longmem=(int*)(mem+1);

*mem=nombre_de_long;
for(char i=0;i&lt;nombre_de_long;i++) longmem[i]=GetLong(i);</pre>
<p>Dans cet exemple, mem est aligné, mais longmem, qui va servir à stocker des longs, est désaligné d’un octet. La boucle qui suit sera globalement 2 fois plus longue à s‘exécuter.<br />
Il faut parfois préférer perdre un peu de place mémoire – ici, nombre_de_mot aurait pu être stocké sur un long même si ça n’est pas utile – plutôt que de désaligner les accès.</p>
<p>Il en va de même pour la longueur des données. Les compilateurs actuels implémentent une partie des fonctions de base en interne (souvent memset, memcpy, etc…). Ces fonctions sont souvent déroulées et adaptées au cas par cas.</p>
<p>Par exemple :<br />
char Tableau[15] ;<br />
memset(Tableau,0,15) ;<br />
Dans ce cas, la taille est connue par le compilateur, mais 15 n’étant pas divisible par 4, le memset va se transformer en :<br />
3 écritures de long à 0, pour vider les 12 premiers octets.<br />
3 écritures de byte à 0, pour vider les 3 octets restants.</p>
<p>Même si ça n’est pas utile, il vaut mieux déclarer :<br />
char Tableau[16] ;<br />
memset(Tableau,0,16) ;<br />
Le compilateur transformera le memset en 4 écritures de long à 0. Moins de code, plus d’efficacité.</p>
<h4>Le dernier recours, l’assembleur</h4>
<p>Pour les masochistes, l’assembleur peut être une solution. Mais attention, sans une maîtrise parfaite des contraintes des pipelines processeur, une routine assembleur peut se révéler plus lente que son homologue en C (forcement, le compilateur connaît très bien ces contraintes) !<br />
Souvent par contre, des routines assembleur très courtes sont très efficaces :</p>
<pre class="brush:cpp">int SwapBytes(int Value); // 0xAABBCCDD devient 0xDDCCBBAA
{
  return ((Value &amp; 0xFF) &lt;&lt; 24) | ((Value &amp; 0xFF00) &lt;&lt; 8) | ((Value &gt;&gt; 8) &amp; 0xFF00) | ((Value &gt;&gt;24) &amp; 0xFF);
}</pre>
<p>Pourra être avantageusement remplacée par :</p>
<pre class="brush:cpp">inline int _fastcall SwapByte(int Value);
{ // eax = value1
  _asm bswap eax;
} // eax = valeur de retour</pre>
<p>Cette dernière routine est infiniment plus rapide puisque :<br />
La fonction sera déroulée dans la fonction appelante.<br />
Le seul paramètre est passé dans un registre, le résultat aussi, pas de cadre de pile – merci le _fastcall.<br />
Une seule instruction assembleur au lieu de 12 pour la première routine dans le meilleur des cas.</p>
<p>Bien entendu les cas comme ça sont assez rares, mais bon…</p>
<p>int a=(b*(0x10000/37/*valeur constante*/))&gt;&gt;16;</p>
