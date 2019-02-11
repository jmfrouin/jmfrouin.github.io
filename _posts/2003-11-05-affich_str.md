---
layout: page
title: Affichage d'une chaine de caractère en assembleur MIPS
author: Jean-Michel Frouin
author_login: jmfrouin
author_email: jm@frouin.me
author_url: http://frouin.me
date: '2003-11-05 21:47:05 +0200'
date_gmt: '2003-11-05 21:47:05 +0200'
categories:
- asm
- mips
tags: []
comments: []
---
<h2>Affichage d'une chaine de caractère en ASM MIPS</h2>
<!--more-->
Affichage et lecture de string pour proc MIPS (xspim)
{% highlight asm %}
    .text
    .globl    __start

__start:  la    $4,entrer_str;
    ori   $2,$0,4;        Syscall 4
    syscall

    la    $4,warning;
    syscall

    la    $4,warning2;
    syscall

    la    $4,read_str
    ori   $5,$0,0x1F; 
    ori   $2,$0,8;        Syscall 8 lecture d'une string au clavier
    syscall

    or    $4,$0,$5;
    ori   $2,$0,4;
    syscall

    .data
read_str: .space    256
entrer_str: .asciiz   "Entrer une phrase :\n";    Demande un entier
warning:  .asciiz   "(Pas plus de 256 caracteres\n"); <=> String(256)
warning2: .asciiz   "... je vous vois venir)");   Pour le fun :)
phrase1:  .asciiz   "Vous avez tape :\n ";      Besoin de commentaires ???
phrase2:  .asciiz   "Et vous etes fier ???\n";    Pour le fun 2 le retour !
{% endhighlight %}
