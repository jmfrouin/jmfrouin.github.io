---
layout: page
title: Cryptage de Vigénère en JAVA
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
<h2>Cryptage / Décryptage de Vigénère en JAVA</h2>
<p>Exemple de cryptage/decryptage d'un message en texte grace a l'gorithme de Vigenere.</p>
<!--more-->
Sauvegarder le fichier suivant dans ListeChar.java
{% highlight java %}
public class ListeChar{
    public char liste[];
    public char get(int x){
        return this.liste[x];
    }
    public void set(int x, char val){
        this.liste[x] = val;
    }
    public ListeChar(int taille){
        this.liste = new char[taille];
        for(int i=0;i<taille;i++)
        {
            this.liste[i]='A';
        }
    }
}
{% endhighlight %}

Sauvegarder le fichier suivant dans Grille.java
{% highlight java %}
public class Grille{
    public ListeChar grille[];
    
    public char get(int x,int y){
        return this.grille[x].get(y);
    }
    
    public void set(int x,int y,char val){
        this.grille[x].set(y,val);
    }
    
    public Grille(int x, int y){
        this.grille = new ListeChar[x];
        for(int i=0;i<this.grille.length;i++)
        {
            this.grille[i] = new ListeChar(y);
        }
    }
}
{% endhighlight %}

Sauvegarder le fichier suivant dans CodDec_Vigenere.java
{% highlight java %}
public class CodDec_Vigenere{
    private static boolean debug=false;
    private static int MAX = 26;
    private static int MAX_Lettres = 1000;
    
    Grille grille = new Grille(MAX,MAX);
    public char get(int x,int y){
        return grille.get(x,y);
    }
    public char CodeLettre(char x,char y){
        if(debug)
        {
            System.out.println("x = "+x+" y = "+y);
            System.out.println("At "+(int)(x-65)+" x "+(int)(y-65));
        }
        if((x==' ') &&(y==' '))
            return ' ';
        else
            return grille.get((int)(x-65),(int)(y-65));
    }
    
    public String Code(String message,String clef){
        char temp[] = new char[message.length()];
        message = message.toUpperCase();
        clef = clef.toUpperCase();
        String key = Arrange_Clef(message.toUpperCase(),clef.toUpperCase());
        if(debug)
        {
            System.out.println(key);
            System.out.println(message);
        }
        for(int i=0;i<message.length();i++)
        {
            try
            {
                temp[i]=CodeLettre(message.charAt(i),key.charAt(i));
            }
            catch(ArrayIndexOutOfBoundsException e)
            {
                temp[i]=message.charAt(i);
                if(debug)
                    System.out.println(message.charAt(i)+" or "+key.charAt(i)+" isn't A-Z letter");
            }
        }
        return String.valueOf(temp);
    }
  
    public char DecodeLettre(char x,char y){
        int i=-1;
        if((x==' ') &&(y==' '))
            return ' ';
        else
        {
            do
            {
                i++;
            }while(grille.get(i,(int)(y-65))!=x);
            return grille.get(i,0);
        }
    }
    public String Decode(String message,String clef){
        char temp[] = new char[message.length()];
        message = message.toUpperCase();
        clef = clef.toUpperCase();
        String key = Arrange_Clef(message.toUpperCase(),clef.toUpperCase());
        for(int i=0;i<message.length();i++)
        {
            try
            {
                temp[i]=DecodeLettre(message.charAt(i),key.charAt(i));
            }
            catch(ArrayIndexOutOfBoundsException e)
            {
                temp[i]=message.charAt(i);
                if(debug)
                    System.out.println(message.charAt(i)+" or "+key.charAt(i)+" isn't A-Z letter");
            }
        }
        return String.valueOf(temp);    
    }
    
    public void Build_Grille(){
        for(int i=0;i<MAX;i++)
        {
            for(int j=0;j<MAX;j++)
            {
                grille.set(i,j,(char)(65+(i+j)%MAX));
            }
        }   
    }
    
    public String Arrange_Clef(String mess,String clef){
        String t="";
        int j=0;
        for(int i=0;i<mess.length();i++)
        {
            if(mess.charAt(i)==' ')
            {
                t=t+" ";
            }
            else
            {
                t=t+String.valueOf(clef.charAt(j));
                j=(j+1)%clef.length();
            }
        }
        return t;
    }
    public CodDec_Vigenere(){
        Build_Grille();
    }
    
}
{% endhighlight %}

Enfin, sauvegarder le fichier suivant dans Vigenere.java
{% highlight java %}
import java.awt.*;
import java.applet.*;
import java.lang.*;
public class Vigenere extends Applet{
    TextField tMess;
    TextField tClef;
    TextField tCrypt;
    Label lMess;
    Label lClef;
    Label lCrypt;
    Button bOK = new Button("Crypter");
    Button bUnOK = new Button("Decrypter");
    CodDec_Vigenere Crypt = new CodDec_Vigenere();
                
    public void init(){
        lMess = new Label("Message a coder : ");
        tMess = new TextField(50);
        lClef = new Label("Clef pour crypter votre texte : ");
        tClef = new TextField(50);
        lCrypt = new Label("Message code : ");
        tCrypt = new TextField(50);
        
        setBackground(Color.white);
        add(lMess);
        add(tMess);
        add(lClef);
        add(tClef);
        add(bOK);
        add(lCrypt);
        add(tCrypt);
        add(bUnOK);
    }
    
    public void paint(Graphics g){
    }
    
    public boolean action(Event e,Object arg){
        if(e.target instanceof Button){
            if (e.target == bOK)
            {
                tCrypt.setText(Crypt.Code(tMess.getText(),tClef.getText()));
            }
            if (e.target == bUnOK)
            {
                tCrypt.setText(Crypt.Decode(tCrypt.getText(),tClef.getText()));
            }
            else
                return false;
        }
        return true;
    }
    
}
{% endhighlight %}

Tout compiler avec : 
{% highlight html %}
javac -deprecation ListeChar.java
javac -deprecation Grille.java
javac -deprecation CodDec_Vigenere.java
javac -deprecation Vigenere.java
{% endhighlight %}

Enfin créer une page html pour l'exploiter : 
{% highlight html %}
<html>
<body>
<center><b>Nombre premiers inferieurs a n a partir du Crible !<br></b></center><br><br>
<center><applet code="Vigenere.class" width=420 height=400 alt="Crible">
Crible</applet></center>
</body>
</html>
{% endhighlight %}
Bonus une classe pour le tester en Java : 
{% highlight java %}
public class test{
    public static void main (String[] args){
    CodDec_Vigenere o = new CodDec_Vigenere();
    String c = new String("Bonjour ceci est un test !");
    String clef = new String("Jean-Michel");
    String d = o.Code(c,clef);
    String e = o.Decode(d,clef);
    System.out.println("Avant = "+c);
    System.out.println("Apres = "+d);
    System.out.println("Avant = "+e);
    }
}
{% endhighlight %}
