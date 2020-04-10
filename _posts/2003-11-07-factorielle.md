---
layout: page
title: Calcul itératif de factorielle en ADA
author: Jean-Michel Frouin
author_login: jmfrouin
author_email: jm@frouin.me
author_url: http://frouin.me
date: '2003-11-07 21:47:05 +0200'
date_gmt: '2003-11-07 21:47:05 +0200'
categories:
- ada
tags: []
comments: []
---
<p>Calcul iteratif de n!.</p>

<!--more-->
{% highlight ada %}
with Ada.Text_Io, Ada.Command_Line, Calcule_Factorielle, Def_My_Natural;
use Ada.Text_Io, Ada.Command_line, Def_My_Natural;

procedure Factorielle is
   
   Rang : My_Natural;   
   Fact : My_Natural;

begin
   -- Test des parametres
   if Argument_Count /= 1 then
      Put_Line("**** Erreur. Usage : factorielle <rang> ");
      return;
   end if;

   -- Recuperation des valeurs des parametres
   Rang := My_Natural'Value (Argument(1));

   begin
      -- Le calcul en lui-meme...
      Fact := Calcule_Factorielle (Rang);
      -- Affichage du resultat
      Put_Line (My_Natural'Image (Rang) & "! = " & My_Natural'Image (Fact));
   exception
      when Constraint_Error =>
         Put_Line ("Factorielle incalculable, depassement de capacite");
   end;
end Factorielle;
{% endhighlight %}

Avec Calcule_Factorielle définit ainsi : 

{% highlight ada %}
with Def_My_Natural;
use Def_My_Natural;

function Calcule_Factorielle (Rang : in My_Natural) return My_Natural is

Factorielle : My_Natural;

begin
   Factorielle := 1;
   for I in 1..Rang loop
      Factorielle:=Factorielle*I;
   end loop;
   return Factorielle;
end Calcule_Factorielle;
{% endhighlight %}

Et Def_My_Natural définit ainsi : 
{% highlight ada %}
package Def_My_Natural is

      type My_Natural is range 0 .. 2**31;
      --| les op\'erateurs *, +, -, / etc sont automatiquement disponibles pour ce type.

end Def_My_Natural;
{% endhighlight %}
