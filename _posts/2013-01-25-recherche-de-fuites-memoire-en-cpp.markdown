---
layout: post
status: publish
published: true
title: Recherche de fuites mémoire en C++
author: Jean-Michel Frouin
author_login: jmfrouin
author_email: jm@frouin.me
author_url: http://frouin.me
date: '2013-01-25 22:58:00 +0100'
date_gmt: '2013-01-25 21:58:00 +0100'
categories:
- cpp
- home
tags: []
comments: []
---
<h2>Introduction</h2>
<p>Pour pouvoir détecter les fuites mémoires, il faut pouvoir garder une trace de toutes les allocations mémoires qui sont faites durant toute l'exécution du programme.<br />
En C++ toutes les allocations de mémoires ce font en utilisant l'opérateur <em>new</em> ou <em>new[]</em> et les libérations de mémoire en utilisant l'opérateur <em>delete</em> ou <em>delete[]</em>.</p>
<!--more-->
<p>Un moyen simple de garder une trace des allocations ou libérations de mémoire est donc de surcharger l'opérateur <em>new</em> et <em>delete</em>.</p>
<h2>Surcharge des opérateurs mémoires du C++</h2>
<p>Dans cette implémentation, chaque opérateur fait appel à une méthode d'une classe <em>CMemoryManager</em> qui gère l'ensemble des allocations / libérations. La classe <em>CMemoryManager</em> est aussi chargée de construire le rapport de fuites mémoires à la fin de l'exécution du programme.<br />
&nbsp;</p>
<pre class="brush:cpp">#ifdef LEAKS

#ifndef _LEAK_DETECTOR_H_
#define _LEAK_DETECTOR_H_

#include "memory_manager.h"

extern CMemoryManager g_mm;
</pre>
<p>Au passage on note, que le singleton n'est pas toujours obligatoire, même si l'on n'utilise qu'une instance d'un objet, du moment que l'on sait ce que l'on fait. Ici l'instance g_mm est créée dans la fonction main de mon programme, et n'est ensuite utilisée, que en la rattrapant au moment de la résolution, via extern.</p>
<pre class="brush:cpp">#ifdef LEAKS
/*!
 * @brief new operator surcharge
 */
inline void* operator new(std::size_t Size, const char* File, int Line)
{
  return g_mm.Allocate(Size, File, Line, false);
}

/*!
 * @brief new[] operator surcharge
 */
inline void* operator new[](std::size_t Size, const char* File, int Line)
{
  return g_mm.Allocate(Size, File, Line, true);
}

/*!
 * @brief delete operator surcharge
 */
inline void operator delete(void* Ptr)
{
  g_mm.Free(Ptr, false);
}

/*!
 * @brief delete[] operator surcharge
 */
inline void operator delete(void* Ptr, const char* File, int Line)
{
  g_mm.NextDelete(File, Line);
  g_mm.Free(Ptr, false);
}

inline void operator delete[](void* Ptr)
{
  g_mm.Free(Ptr, true);
}

inline void operator delete[](void* Ptr, const char* File, int Line)
{
  g_mm.NextDelete(File, Line);
  g_mm.Free(Ptr, true);
}
#endif // _LEAK_DETECTOR_H__
</pre>
<p>Ici, on surcharge les opérateurs <em>new</em> et <em>delete</em> en inline. Du coup à la compilation, le compilateur remplacera les appels à ces méthodes, par la définition de la méthode. </p>
<pre class="brush:cpp">
#undef delete

#ifndef new
#define new    new(__FILE__, __LINE__)
#define delete g_mm.NextDelete(__FILE__, __LINE__), delete
#endif
#endif // LEAKS</pre>
<p>&nbsp;<br />
L'utilisation des macros de pré-compilation (__FILE__ et __LINE__) dans la redéfinition des opérateurs, permet de localiser l'emplacement (dans les fichiers) d'une allocation ou d'une libération de mémoire.</p>
<p>Bref, tout ce fichier n'est qu'une soupe pour le pré-compilateur :)<br />
&nbsp;</p>
<p>Déclaration de la classe CMemoryManager :<br />
&nbsp;</p>
<pre class="brush:cpp">#ifndef __MEMORY_MANAGER_H__
#define __MEMORY_MANAGER_H__

#include &lt;fstream&gt;
#include &lt;map&gt;
#include &lt;stack&gt;
#include &lt;string&gt;
#include &lt;def.h&gt;

#include "log.h"

/*!
 * @brief Memory manager, in fact for the moment it's only a leak detector.
 */
class CMemoryManager : public ILog
{
  public :
    /*!
     * @brief        Default constructor.
     */
    CMemoryManager();
    /*!
     * @brief        Destructor.
     */
    ~CMemoryManager();

    /*!
     * @brief        Do memory allocation.
     * @param        _size Size to allocate.
     * @param        _file Store the file where delete is did.
     * @param        _line Store the line where delete is did.
     * @param        _array Pointer point on array type ?.
     */
    void* Allocate(std::size_t _size, const std::string&amp; _file, int _line, bool _array);
    /*!
     * @brief        Free memory.
     * @param        _ptr Pointer on memory zone to free.
     * @param        _array Pointer point on array type ?.
     */
    void Free(void* _ptr, bool _array);
    /*!
     * @brief        Default constructor.
     * @param        _file Store the file where delete is did.
     * @param        _line Store the line where delete is did.
     */
    void NextDelete(const std::string&amp; _file, int _line);

    /*!
     * @brief From ILog
     */
    void Report();

  private:
    /*!
     * @brief Memory stucture.
     */
    struct TBlock
    {
      std::size_t                             Size;
      std::string                             File;
      unsigned int                    Line;
      bool                                    Array;
      static std::size_t              Total;
    };

    typedef std::map&lt;void*, TBlock&gt; TBlockMap;

    TBlockMap          m_Blocks;
    std::stack&lt;TBlock&gt; m_DeleteStack;
};
#endif // __MEMORY_MANAGER_H__</pre>
<p>&nbsp;</p>
<p>Définition de la classe CMemoryManager :</p>
<p>&nbsp;</p>
<pre class="brush:cpp">#include &lt;iomanip&gt;
#include &lt;sstream&gt;
#include &lt;iostream&gt;

#include "memory_manager.h"

std::size_t CMemoryManager::TBlock::Total = 0;

CMemoryManager::CMemoryManager()
{
  m_File.open("_memoryleaks.log");
  if (!m_File)
  {
    std::cout &lt;&lt; "Erreur : Cannot open m_File" &lt;&lt; std::endl;
  }

  m_File &lt;&lt; "====================================================================================" &lt;&lt; std::endl;
  m_File &lt;&lt; " MemoryManager v" &lt;&lt; VERSION_MEMORY_MANAGER &lt;&lt; " - Report (Compiled on " &lt;&lt; __DATE__ &lt;&lt; " @ " &lt;&lt; __TIME__ &lt;&lt; ")" &lt;&lt; std::endl;
  m_File &lt;&lt; "====================================================================================" &lt;&lt; std::endl &lt;&lt; std::endl;
}

CMemoryManager::~CMemoryManager()
{
  std::cout &lt;&lt; "[DEBUG] [CMemoryManager] ~CMemoryManager()" &lt;&lt; std::endl;

  if (m_Blocks.empty())
  {
    m_File &lt;&lt; std::endl;
    m_File &lt;&lt; "====================================================================================" &lt;&lt; std::endl;
    m_File &lt;&lt; "   No leak detected, congratulations !  " &lt;&lt; std::endl;
    m_File &lt;&lt; "====================================================================================" &lt;&lt; std::endl &lt;&lt; std::endl;
  }
  else
  {
    m_File &lt;&lt; std::endl;
    m_File &lt;&lt; "====================================================================================" &lt;&lt; std::endl;
    m_File &lt;&lt; " Oops... Some leaks have been detected  " &lt;&lt; std::endl;
    m_File &lt;&lt; "====================================================================================" &lt;&lt; std::endl &lt;&lt; std::endl;
    m_File &lt;&lt; std::endl;
    Report();
  }
}

void CMemoryManager::Report()
{
  std::cout &lt;&lt; "[DEBUG] [CMemoryManager] ReportLeaks()" &lt;&lt; std::endl;

  std::size_t TotalSize = 0;
  for (TBlockMap::iterator i = m_Blocks.begin(); i != m_Blocks.end(); ++i)
  {
    TotalSize += i-&gt;second.Size;
    m_File &lt;&lt; "-&gt; 0x" &lt;&lt; i-&gt;first
      &lt;&lt; " | "   &lt;&lt; std::setw(7) &lt;&lt; std::setfill(' ') &lt;&lt; static_cast&lt;int&gt;(i-&gt;second.Size) &lt;&lt; " bytes"
      &lt;&lt; " | "   &lt;&lt; i-&gt;second.File &lt;&lt; " (" &lt;&lt; i-&gt;second.Line &lt;&lt; ")" &lt;&lt; std::endl;
    free(i-&gt;first);
  }

  m_File &lt;&lt; std::endl &lt;&lt; std::endl &lt;&lt; "-- "
    &lt;&lt; static_cast&lt;int&gt;(m_Blocks.size()) &lt;&lt; " blocs not empty, "
    &lt;&lt; static_cast&lt;int&gt;(TotalSize)       &lt;&lt; " bytes --"
    &lt;&lt; std::endl;

}

void* CMemoryManager::Allocate(std::size_t _size, const std::string&amp; _file, int _line, bool _array)
{
  void* Ptr = malloc(_size);

  TBlock NewBlock;
  NewBlock.Size  = _size;
  NewBlock.File  = _file;
  NewBlock.Line  = _line;
  NewBlock.Array = _array;
  NewBlock.Total += _size;
  m_Blocks[Ptr]  = NewBlock;

  m_File &lt;&lt; "+++" &lt;&lt; " " &lt;&lt; Ptr &lt;&lt; " " &lt;&lt; static_cast&lt;int&gt;(NewBlock.Size) &lt;&lt; " " &lt;&lt; NewBlock.Total &lt;&lt; " " &lt;&lt; NewBlock.File &lt;&lt; " " &lt;&lt; NewBlock.Line &lt;&lt; std::endl;

  return Ptr;
}

void CMemoryManager::Free(void* _ptr, bool _array)
{
  TBlockMap::iterator It = m_Blocks.find(_ptr);

  std::cout &lt;&lt; "[DEBUG] [CMemoryManager] Free(" &lt;&lt; _ptr &lt;&lt; ") " &lt;&lt; std::endl;

  if (It == m_Blocks.end())
  {
    free(_ptr);
    return;
  }

  if (It-&gt;second.Array != _array)
  {
    m_File &lt;&lt; "-- ERREUR | 0x" &lt;&lt; _ptr &lt;&lt; " @ " &lt;&lt; It-&gt;second.File &lt;&lt; " Line : " &lt;&lt; It-&gt;second.Line &lt;&lt; std::endl;
    return;
  }

  if(!m_DeleteStack.empty())
  {
    m_File &lt;&lt; "---" &lt;&lt; " " &lt;&lt; _ptr &lt;&lt; " " &lt;&lt; static_cast&lt;int&gt;(It-&gt;second.Size) &lt;&lt; " " &lt;&lt; m_DeleteStack.top().File &lt;&lt; " " &lt;&lt; m_DeleteStack.top().Line &lt;&lt; std::endl;
  }
  else
  {
    m_File &lt;&lt; "---" &lt;&lt; " " &lt;&lt; _ptr &lt;&lt; " " &lt;&lt; static_cast&lt;int&gt;(It-&gt;second.Size) &lt;&lt; std::endl;
  }

  m_Blocks.erase(It);
  if(!m_DeleteStack.empty())
  {
    m_DeleteStack.pop();
  }
  free(_ptr);
}

void CMemoryManager::NextDelete(const std::string&amp; _file, int _line)
{
  TBlock Delete;
  Delete.File = _file;
  Delete.Line = _line;

  m_DeleteStack.push(Delete);
}</pre>
<p>Article ayant été lu pendant la mise au point de ce détecteur de fuites mémoires (leaks):<br />
<a href="http://www.scs.stanford.edu/~dm/home/papers/c++-new.html" target"=_blank">My Rant on C++'s operator new</a></p>
