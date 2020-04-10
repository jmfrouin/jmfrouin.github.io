---
layout: post
status: publish
published: true
title: C++ et l'embarqué sous GNU/Linux
author: Jean-Michel Frouin
author_login: jmfrouin
author_email: jm@frouin.me
author_url: http://frouin.me
date: '2013-02-03 11:23:03 +0100'
date_gmt: '2013-02-03 10:23:03 +0100'
categories:
- cpp
- embarque
- home
tags: []
comments: []
---
<h2>Retirer les patrons STL</h2>
<h3>Introduction</h3>
<p>L'utilisation de la STL dans des projets embarqués pose un problème majeur, celui de la duplication de code dans les objets binaires. En effet les patrons (Qui sont des morceaux de code génériques) sont spécialisés durant la précompilation. On se retrouve vite avec plusieurs kilos de code pour rien. Pour contourner ce problème (Dû aux contraintes du monde embarqué.) il suffit d'encapsuler l'ensemble des patrons utilisés dans une classe à part. Ainsi le code des patrons de la STL sera centralisé dans un binaire, celui de la classe qui encapsule les patrons.<br />
<!--more-->
Imaginons qu'un binaire utilise abondamment les patrons STL. Tout d'abord il faut identifier les patrons STL utilisés par le binaire. Il est possible de récupérer la liste en utilisant : <em>nm -C binaire.o</em>.</p>
<h3>Etude de cas</h3>
<p>Prenons l'exemple, d'un binaire qui utilise les patrons STL des std::string :</p>
<pre class="brush:cpp">U __gxx_personality_v0
00000b56 T main
U _Unwind_Resume
00000000 T f1()
000005a8 T f2()
U std::string::compare(char const*) const
U std::allocator::allocator()
U std::allocator::~allocator()
U std::string::append(char const*)
U std::string::operator=(std::string const&amp;)
U std::basic_string&lt;char, std::char_traits, std::allocator &gt;::basic_string(char const*, std::allocator const&amp;)
U std::basic_string&lt;char, std::char_traits, std::allocator &gt;::basic_string(std::string const&amp;)
U std::basic_string&lt;char, std::char_traits, std::allocator &gt;::~basic_string()
U std::string::operator+=(char const*)
00000000 W bool std::operator!=&lt;char, std::char_traits, std::allocator &gt;(std::basic_string&lt;char, std::char_traits, std::allocator &gt; const&amp;, char const*)
00000000 W std::basic_string&lt;char, std::char_traits, std::allocator &gt; std::operator+&lt;char, std::char_traits, std::allocator &gt;(std::basic_string&lt;char, std::char_traits, std::allocator &gt; const&amp;, char const*)</pre>
<p>On voit, clairement, que ce binaire utilise abondamment le patron STL des strings. Pour peu qu'un projet utilise les strings et soit constitué de plusieurs binaires, il y a aura une duplication du code STL dans chacun des binaires. Si le but est de produire des binaires de taille minimum, il semble évident qu'un travail est à faire pour récupérer la taille occupée par le code STL.</p>
<p>Pour ce faire, il suffit d'encapsuler tout le code utilisé dans une classe pour centraliser l'utilisation des patrons. Le code de l'objet CString encapsule les méthodes utilisées par ce binaire :</p>
<p>Définition la classe CString</p>
<pre class="brush:cpp">#ifndef __CSTRING_H__
#define __CSTRING_H__

#include &lt;string&gt;
#include &lt;iostream&gt;

class CString : protected std::string
{
  friend std::ostream&amp; operator&lt;&lt;(std::ostream&amp; _os, const CString&amp; _string);

  public:
    static const size_t npos = std::string::npos;

  public:
    CString();
    CString(const char* _name);
    CString(const CString&amp; _name);
    ~CString();

    //From std::string
    const CString operator+(const char* _string);
    const CString operator+(const CString&amp; _string);
    CString&amp; operator+=(const char* _string);
    CString&amp; operator+=(const CString&amp; _string);
    CString&amp; operator=(const CString&amp; _string);
    bool operator==(const char* _string) const;
    bool operator==(const CString&amp; _string) const;
    bool operator!=(const char* _string) const;
    bool operator&lt;(const char* _string) const;
    bool operator&lt;(const CString&amp; _string) const;
    bool operator&gt;(const char* _string) const;
    bool operator&gt;(const CString&amp; _string) const;

    const char* c_str() const;
    size_t find(char _char) const;
    size_t find_last_of(char _char) const;
    CString substr(size_t _pos, size_t _npos)const;
    CString substr(int _nb)const;
    CString&amp; append(const CString&amp; _string);
    CString&amp; assign(const CString&amp; _string);
    size_t length() const;
};
#endif //__CSTRING_H__</pre>
<p>Et l'implémentation :</p>
<pre class="brush:cpp">#include "cstring.h"

CString::CString()
{
}

CString::CString(const char* _name)
:std::string(_name)
{
}

CString::CString(const CString&amp; _name)
{
  const std::string* l_tmp;
  l_tmp = &amp;_name;
  std::string::assign(*l_tmp);
}

CString::~CString()
{
}

const CString CString::operator+(const char* _string)
{
  std::string l_tmp((*this).c_str());
  l_tmp += _string;
  CString l_ret(l_tmp.c_str());
  return l_ret;
}

const CString CString::operator+(const CString&amp; _string)
{
  return (*this) + _string.c_str();
}

CString&amp; CString::operator+=(const char* _string)
{
  std::string::operator+=(_string);
  return *this;
}

CString&amp; CString::operator+=(const CString&amp; _string)
{
  const std::string* l_tmp;
  l_tmp = &amp;_string;
  std::string::operator+=(*l_tmp);
  return *this;
}

CString&amp; CString::operator=(const CString&amp; _string)
{
  const std::string* l_tmp;
  l_tmp = &amp;_string;
  std::string::operator=(*l_tmp);
  return *this;
}

bool CString::operator==(const char* _string) const
{
  bool l_ret;
  std::string l_this((*this).c_str());
  std::string l_tmp(_string);
  l_ret = l_this == l_tmp;
  return l_ret;
}

bool CString::operator==(const CString&amp; _string) const
{
  bool l_ret;
  l_ret = (*this) == _string.c_str();
  return l_ret;
}

bool CString::operator!=(const char* _string) const
{
  bool l_ret;
  std::string l_this((*this).c_str());
  std::string l_tmp(_string);
  l_ret = l_this != l_tmp;
  return l_ret;
}

bool CString::operator&lt;(const char* _string) const
{
  bool l_ret;
  std::string l_this((*this).c_str());
  std::string l_tmp(_string);
  l_ret = l_this &lt; l_tmp;
  return l_ret;
}

bool CString::operator&lt;(const CString&amp; _string) const
{
  bool l_ret;
  l_ret = (*this) &lt; _string.c_str();
  return l_ret;
}

bool CString::operator&gt;(const char* _string) const
{
  return ((*this).c_str() &gt; _string);
}

bool CString::operator&gt;(const CString&amp; _string) const
{
  const std::string* l_tmp;
  l_tmp = &amp;_string;
  return ((*this).c_str() &gt; (*l_tmp));
}

const char* CString::c_str() const
{
  const std::string* l_tmp;
  l_tmp = this;
  return (*l_tmp).c_str();
}

size_t CString::find(char _char) const
{
  return std::string::find(_char);
}

size_t CString::find_last_of(char _char) const
{
  return std::string::find_last_of(_char);
}

CString CString::substr(size_t _pos, size_t _npos)const
{
  std::string l_tmp = std::string::substr(_pos, _npos);
  return CString(l_tmp.c_str());
}

CString CString::substr(int _nb) const
{
  std::string l_tmp = std::string::substr(_nb);
  return CString(l_tmp.c_str());
}

CString&amp; CString::append(const CString&amp; _string)
{
  const std::string* l_tmp;
  l_tmp = &amp;_string;
  std::string::append(*l_tmp);
  return *this;
}

CString&amp; CString::assign(const CString&amp; _string)
{
  const std::string* l_tmp;
  l_tmp = &amp;_string;
  std::string::assign(*l_tmp);
  return *this;
}

size_t CString::length() const
{
  return std::string::length();
}

std::ostream&amp; operator&lt;&lt;(std::ostream&amp; _os,const CString&amp; _string)
{
  const std::string* l_tmp;
  l_tmp = &amp;_string;
  _os &lt;&lt; (*l_tmp);
  return _os;
}</pre>
<p>Ainsi le code de la STL sera recopié, durand la précompilation, dans le fichier cstring.cpp et sera donc exclusivement contenu dans le binaire cstring.o.</p>
<p>Enfin, il suffit de vérifier que tout fonctionne correctement en recherchant à nouveau les patrons STL dans le nouveau binaire :</p>
<pre class="brush:cpp">U __gxx_personality_v0
00000892 T main
U _Unwind_Resume
00000000 T f1()
00000446 T f2()
U CString::operator=(CString const&amp;)
U CString::CString(char const*)
U CString::~CString()
U CString::operator+(char const*)
U CString::operator+=(char const*)
U CString::operator!=(char const*) const</pre>
<p>Voilà, nos patrons STL des strings ne sont plus dans le binaire.</p>
<h3>Tailles des objets binaires</h3>
<p>Le binaire utilisant les patrons STL (code/analyse_templates/test_template.cpp) : 33 Ko (Normal), 4.7Ko (Strippée)</p>
<p>Le binaire utilisant le binaire encapsulant les patrons STL (code/analyse_templates/test_template2.cpp) : 31Ko (Normal), 3.4Ko (Strippée)</p>
<p>Binaire encapsulant les patrons STL (code/analyse_templates/cstring.cpp) : 45Ko (Normal), 5.9Ko (Strippée)</p>
<h3>Conclusion</h3>
<p>On constate que l'on a réussi à gagner 1.3Ko sur l'objet binaire, mais nous avons un nouvel objet binaire de 5.9Ko, donc au final on se retrouve avec beaucoup de code en plus. Il est bien évident que cela est efficace si beaucoup de binaires utilisent les mêmes patrons. TODO : Compléter l'exemple pour que l'on se retrouve au final avec un gain de place.</p>
<h2>Supprimer les symboles</h2>
<p>Pour supprimer complètement les symboles d'un objet il est possible de faire appel à l'utilitaire <em>strip</em> dont c'est le rôle.</p>
<h2>Optimisation des if avec enum</h2>
<p>Lorsque l'on veut vérifier qu'une variable (de type enum) :</p>
<pre class="brush:cpp">if((Type == CBaseComponent::eLabel) || (Type == CBaseComponent::eLink) || (Type == CBaseComponent::eCheckBox))</pre>
<p>Dont voici le code assembleur généré :</p>
<pre class="brush:cpp">0044E70A cmp dword ptr [Type],8
0044E70E je Interface::CPanel::RebuildComponents+190h (44E720h)
0044E710 cmp dword ptr [Type],9
0044E714 je Interface::CPanel::RebuildComponents+190h (44E720h)
0044E716 cmp dword ptr [Type],7
0044E71A jne 0044EA15</pre>
<p>On remarque 3 tests de comparaisons!</p>
<p>On peut en faire uniquement un :</p>
<pre class="brush:cpp"> if((1&lt;&lt;Type) &amp; ((1&lt;&lt;CBaseComponent::eLabel) | (1&lt;&lt;CBaseComponent::eLink) | (1&lt;&lt;CBaseComponent::eCheckBox)))</pre>
<p>Dont le code assembleur est :</p>
<pre class="brush:cpp">0044E70A mov eax,1
0044E70F mov ecx,dword ptr [Type]
0044E712 shl eax,cl
0044E714 and eax,380h
0044E719 je 0044EA14</pre>
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
