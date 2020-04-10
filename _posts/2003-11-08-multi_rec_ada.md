---
layout: page
title: Multiplication récursive en ADA
author: Jean-Michel Frouin
author_login: jmfrouin
author_email: jm@frouin.me
author_url: http://frouin.me
date: '2003-11-08 21:47:05 +0200'
date_gmt: '2003-11-08 21:47:05 +0200'
categories:
- ada
tags: []
comments: []
---
<p>Multiplication récursive en en ADA.</p>
<!--more-->

Multiplication récursive en ADA : 

{% highlight ada %}
with Ada.Text_Io, Ada.Command_Line;
use Ada.Text_Io, Ada.Command_Line;

procedure Multiplier_Recursif_Command is
  type Une_Liste is range 0..99999;
  type Un_Resultat_Positif is range 0..9*9*9*9*9;

  package Es_Une_Liste is new Ada.Text_IO.Integer_IO(Une_Liste);
  package Es_Un_Resultat_Positif is new Ada.Text_IO.Integer_IO(Un_Resultat_Positif);

  function Produit_Chiffres(Liste : Une_Liste) return Un_Resultat_Positif;

  procedure Affichage_Resultat(Resultat : Un_Resultat_Positif; SigneMoins : boolean) is
  begin
    Put("Le resultat de la multiplication est ");
    if (SigneMoins) then
        Put_Line("-"&Un_Resultat_Positif'Image(Resultat)(2..Un_Resultat_Positif'Image(Resultat)'last)) ;
    else
        Put_Line(Un_Resultat_Positif'Image(Resultat)(2..Un_Resultat_Positif'Image(Resultat)'last)) ;
    end if;
  end Affichage_Resultat;

  function Produit_Chiffres(Liste : Une_Liste) return Un_Resultat_Positif is
  begin
    if (Liste mod 10)=0 then
        return 1;
     else
        return Un_Resultat_Positif((Liste-(Liste/10)*10))*Produit_Chiffres(Liste/10);
     end if;
  end Produit_Chiffres;

begin
  if Argument_Count /= 1 then
  Put_Line("La commande necessite exactement un parametre (un nombre de cinq chiffres au plus)");
    return;
  end if;

  if Integer'Value(Argument(1))<0 then
     Affichage_Resultat(Produit_Chiffres(Une_Liste(-1*Integer'Value(Argument(1)))),true);
  else
     Affichage_Resultat(Produit_Chiffres(Une_Liste(Integer'Value(Argument(1)))),false);
  end if;
end Multiplier_Recursif_Command;
{% endhighlight %}
