---
layout: post
status: publish
published: true
title: Optimisation C++/Assembleur par l'exemple
author: Jean-Michel Frouin
author_login: jmfrouin
author_email: jm@frouin.me
author_url: http://frouin.me
date: '2013-02-06 19:00:39 +0100'
date_gmt: '2013-02-06 18:00:39 +0100'
categories:
- gcc
- cpp
- asm
tags: []
comments: []
---
<p>Suite à la recopie de mon document sur les <a title="Optimisation en C++" href="http://frouin.me/optimisation-en-cpp/">optimisations en C++</a>, j'ai eu envie de rejouer avec l'assembleur (ici x86) pour démontrer les notions exposées dans ce <a title="Optimisation en C++" href="http://frouin.me/optimisation-en-cpp/">document</a>.</p>
<!--more-->
<p>Avant tout il faut savoir, comment, demander à gcc de nous compiler un fichier source en assembleur. Cela passe par le paramètre -S :</p>
<pre class="brush:shell">gcc -S file.cxx</pre>
<p>Produira le fichier file.s en assembleur.</p>
<p>Maintenant comparons l'assembleur produit par trois sources assez proche :</p>
<pre class="brush:cpp">int main() 
{ 
  int a=2; 
  a=a&lt;&lt;2; 
  return 0; 
}</pre>
<pre class="brush:cpp">int main()
{
  int a=2;
  a=a*4;
  return 0;
}</pre>
<pre class="brush:cpp">int main()
{
  int a=2;
  a=a*3;
  return 0;
}</pre>
<p>Et comparons l'assembleur produit (on ne garde que les parties non communes aux trois sources assembleur):</p>
<pre class="brush:cpp">.file "mult1.cxx"
sall $2,-4(%rbp)</pre>
<pre class="brush:cpp">.file "mult2.cxx"
sall $2,-4(%rbp)</pre>
<pre class="brush:cpp">.file "mult3.cxx"
movl -4(%rbp),%edx
movl %edx,%eax
addl %eax,%eax
addl %edx,%eax
movl %eax,-4(%rbp)</pre>
<p>On se rend bien compte de deux choses :<br />
- Pour le compilateur gcc/x86, il à fait l'optimisation lui même (Mais à moins de vérifier, il vaut mieux la faire nous dans le code plutôt que de partir du principe que le compilateur le fera pour nous) de remplacer la multiplication d'un facteur de 2 par un décalage de bit a gauche.<br />
- Que le fait de ne pas avoir décomposé la multiplication par 3 en décalage d'un bit à gauche plus une fois a, à générer un code qui va consommer beaucoup plus de cycle CPU que s'y nous l'avions fait. (nous gagnerons à priori une instruction assembleur, pas plus sur cet exemple simple)</p>
<p>Allez, faisons le test : </p>
<pre class="brush:cpp">int main()
{
  int a=2;
  a=a<<1+a;
  return 0;
}</pre>
<pre class="brush:cpp">
movl -4(%rbp),%eax
addl $1,%eax
movl %eax,%ecx
sall %cl,-4(%rbp)
</pre>
<p>Voila, l'homme triomphe encore de la machine :)</p>
