---
layout: page
title: Gestion d'une librairie de livres en ADA
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
<p>Gestion d'une librairie de livres.</p>

<!--more-->
{% highlight ada %}
with Ada.Text_Io, Ada.Integer_Text_IO;
use Ada.Text_Io, Ada.Integer_Text_IO;

procedure libraire is
  type Code_Editeur is range 0..999;
  type Isbn is range 0..9999999;
  type T_Livre is 

  record
    Titre,Auteur : String(1..15) := (others => ' ');
    Code : Code_Editeur;
    Num_Isbn : Isbn;
    Ex_Dispo : Natural;
    Prix : Float;
  end record;

  type Tab_Livres is array(Natural range <>) of T_Livre;
  type T_Rayon (Taille : Natural) is

  record
    Tab : Tab_Livres(1..Taille);
    Nb_Dispo : Natural;
  end record;

  type T_Bibliotheque  is

  record
    Policier : T_Rayon(200);
    Fantastique : T_Rayon(300);
    Enfant : T_Rayon(100);
    BD : T_Rayon(400);
    Essai : T_Rayon(200);
    Roman : T_Rayon(200);
    Histoire : T_Rayon(100);
    Inclassable : T_Rayon(50);
  end record;

  procedure Init(T : in out T_Livre) is
  begin
    T.Titre:="Titre          ";
    T.Auteur:="Auteur         ";
    T.Code:=666;
    T.Num_Isbn:=7777777;
    T.Ex_Dispo:=7;
    T.Prix:=0.0;
  end Init;

  procedure Affich_Livre(L : T_Livre) is
  begin 
    Put_Line("Affich livre : ");
    Put_Line("__________________________");
    Put("Titre : ");
    Put(L.Titre);
    New_Line;
    Put("Auteur : ");
    Put(L.Auteur);
    New_Line;
    Put("Exemplaire(s) dispo(s) : ");
    Put(L.Ex_Dispo);
    New_Line;
    Put_Line("__________________________");
  end Affich_Livre;

  procedure Init_Rayon(Rayon : in out T_Rayon; Taille : Natural) is 
  begin
    for I in 1..Taille loop
      Init(Rayon.Tab(I));
    end loop;
    Rayon.Nb_Dispo:=0;
  end Init_Rayon;

  procedure Affich_Rayon(R : T_Rayon; Taille:Natural) is
  begin 
    Put_Line("Affichage du rayon : ");
    Put_Line("__________________________");
    Put("Taille : ");
    Put(Taille);
    New_Line;
    Put_Line("__________________________");
    for I in 1..Taille loop
      Affich_Livre(R.Tab(I));
    end loop;
  end Affich_Rayon;

  procedure Ajout_Rayon(Rayon : in out T_Rayon; Taille : Natural; T : T_Livre) is
  find : boolean;
  begin
    find := false;
    if(Rayon.Nb_Dispo/=Taille) then
      for I in 1..Taille loop
        if(Rayon.Tab(I).Titre="Titre          " and not find) then
          Rayon.Tab(Rayon.Nb_Dispo+1):=T;
          Rayon.Nb_Dispo:=Rayon.Nb_Dispo+1;
          Put("Ajout effectué sans problème a la position : ");
          Put(Rayon.Nb_Dispo);
          New_Line;
          find := true;
        end if;
      end loop;
    else
      Put_Line("Plus de place");
    end if;
  end Ajout_Rayon;

  procedure Retrait_Rayon(Rayon : in out T_Rayon; Taille : Natural; T : T_Livre) is
  find : boolean;
  begin
    find := false;
    for I in 1..Taille loop
      if Rayon.Tab(I).Titre=T.Titre then
        Init(Rayon.Tab(I));
        Rayon.Nb_Dispo:=Rayon.Nb_Dispo-1;
        Put("Retrait effectue a la Position : ");
        Put(Rayon.Nb_Dispo+1);
        New_Line;
        find := true;
      end if;
    end loop;
    if not find then
      Put_Line("Non trouve !!");
    end if;
  end Retrait_Rayon;

  function Recherche(Biblio : T_Bibliotheque; T : T_Livre) return boolean is
  find : boolean;
  begin
    find := false;
    Put("Recherche d'un ouvrage :");
    Put(T.Titre);
    New_Line;
    for I in 1..200 loop
      if(Biblio.Policier.Tab(I).Titre=T.Titre and not find) then
        Put("Trouve dans Policier a la position :");
        Put(I);
        New_Line;
        find := true;
      end if;
    end loop;
    for I in 1..300 loop
      if(Biblio.Fantastique.Tab(I).Titre=T.Titre and not find) then
        Put("Trouve dans Fantastique a la position :");
        Put(I);
        New_Line;
        find := true;
      end if;
    end loop;

    for I in 1..100 loop
      if(Biblio.Enfant.Tab(I).Titre=T.Titre and not find) then
        Put("Trouve dans Enfant a la position :");
        Put(I);
        New_Line;
        find := true;
      end if;
    end loop;

    for I in 1..400 loop
      if(Biblio.BD.Tab(I).Titre=T.Titre and not find) then
        Put("Trouve dans BD a la position :");
        Put(I);
        New_Line;
        find := true;
      end if;
    end loop;

    for I in 1..200 loop
      if(Biblio.Essai.Tab(I).Titre=T.Titre and not find) then
        Put("Trouve dans Essai a la position :");
        Put(I);
        New_Line;
        find := true;
      end if;
    end loop;

    for I in 1..200 loop
      if(Biblio.Roman.Tab(I).Titre=T.Titre and not find) then
        Put("Trouve dans Roman a la position :");
        Put(I);
        New_Line;
        find := true;
      end if;
    end loop;

    for I in 1..100 loop
      if(Biblio.Histoire.Tab(I).Titre=T.Titre and not find) then
        Put("Trouve dans Histoire a la position :");
        Put(I);
        New_Line;
        find := true;
      end if;
    end loop;

    for I in 1..50 loop
      if(Biblio.Inclassable.Tab(I).Titre=T.Titre and not find) then
        Put("Trouve dans Inclassable a la position :");
        Put(I);
        New_Line;
        find := true;
      end if;
    end loop;
    return find;
  end Recherche;

  T : T_Livre := ("Les démons     ","Dostovieski    ",873,1239283,3,10.3);
  T1 : T_Livre := ("Les démons 2   ","Dostovieski    ",823,1234333,1,10.3);
  L : T_Livre;
  Policier : T_Rayon(200);
  Biblio : T_Bibliotheque;

begin
  Init(L);
  Affich_Livre(T);
  Affich_Livre(L);
  Init_Rayon(Biblio.Policier,200);
  Ajout_Rayon(Biblio.Policier,200,T1);
  Affich_Rayon(Biblio.Policier,5);
  Retrait_Rayon(Biblio.Policier,200,T1);
  Retrait_Rayon(Biblio.Policier,200,T);
  Affich_Rayon(Biblio.Policier,5);
  Ajout_Rayon(Biblio.Policier,200,T1);
  Ajout_Rayon(Biblio.Policier,200,T);
  Affich_Rayon(Biblio.Policier,5);
  if Recherche(Biblio,T) then
    Put_Line("Trouve");
  else
    Put_Line("Non Trouve");
  end if;
end libraire;
{% endhighlight %}
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
