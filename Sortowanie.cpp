// **********************************
// *Rafa³ Meisel					*
// *Informatyka, Rybnik             *
// *Semestr 5, 2016 / 2017			*
// *								*
// *Projekt Jêzyków Asemblerowych   *
// *Algorytm Sortuj¹cy :			*
// *Sortowanie Shella			    *
// *								*
// **********************************
#include "Sortowanie.h";

namespace C_Sortowanie
{
	void C_SortowanieShella(int *tab, int dl)
	{
		int i, j, k, tmp;
		for (i = dl / 2; i > 0; i = i / 2)
		{
			for (j = i; j < dl; j++)
			{
				for (k = j - i; k >= 0; k = k - i)
				{
					if (tab[k + i] >= tab[k])
						break;
					else
					{
						tmp = tab[k];
						tab[k] = tab[k + i];
						tab[k + i] = tmp;
					}
				}
			}
		}
	}
}
