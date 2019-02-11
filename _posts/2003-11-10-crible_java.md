---
layout: page
title: Crible d'eratosthène en JAVA
author: Jean-Michel Frouin
author_email: jm@frouin.me
author_url: http://frouin.me
date: '2003-11-11 21:47:05 +0200'
date_gmt: '2003-11-11 21:47:05 +0200'
categories:
- java
tags: []
comments: []
---
<h2>Crible d'erastosthène en JAVA</h2>
<p>Le crible des nombres premiers inferieurs a N.</p>
<!--more-->
Sauvegarder le fichier suivant dans crible.java
{% highlight java %}
import java.awt.*;
import java.applet.*;
import java.lang.*;

public class Crible extends Applet{
    TextField TValN;
    Label LValN;
    Button bOK = new Button("Calcul");
    int Nb_Raye[] = new int[1000];
    int Nb=1000;

    public void init(){
        LValN = new Label("Entrer une valeur comprise entre 1 et 1000 :");
        TValN = new TextField(30);
        add(LValN);
        add(TValN);
        add(bOK);
        ini();
    }

    public void ini(){
        int i;
        for(i=0;i<Nb;i++)
        {   
          Nb_Raye[i]=1;
        }    
    }

    public void paint(Graphics g){
        int x=0;
        int xx=0,yy=80;
        String s = TValN.getText();
        Crible();
        for(x=0;x<Nb;x=x+1)
        {
            if(Nb_Raye[x]==1)
            {
                g.drawString(String.valueOf(x),xx,yy);
                xx = xx + 30;
                if(xx>400)
                {
                    xx = 0;
                    yy = yy + 20;
                }
            }
        }
    }

    public void Crible()
    {
      int prem=2,i,j;
      for(i=prem;i<(int)Math.sqrt(Nb);i++)
      {
          for(j=1;j<(Nb-i);j++)
          {
            if((i+j)%i==0)
              Nb_Raye[i+j]=0;
          }
        }
    }

    public boolean action(Event e,Object arg){
        if(e.target instanceof Button){
            if (e.target == bOK)
            {
                Nb = Integer.parseInt(TValN.getText());
                repaint();
            }
            else
                return false;
        }
        return true;
    }
}
{% endhighlight %}

En suite compiler le avec <b>javac -deprecation Crible.java</b>

Enfin créer une page html pour l'exploiter : 

{% highlight html %}
<html>

<body>
<center><b>Nombre premiers inferieurs a n a partir du Crible !<br></b></center><br><br>
<center><applet code="Crible.class" width=420 height=400 alt="Crible">
Crible</applet></center>
</body>
</html>
{% endhighlight %}
