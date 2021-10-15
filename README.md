# Lottosimulaatio
Simuloidaan tuottojakautumia pelatessa lottoa 50 vuoden ajan vs. sama sijoitettuna indeksiin.

## Sijoitetut rahaa

Rahaa sijoitetaan 1 euro viikossa jolla ostetaan joko viikottainen lottorivi tai vaihtoehtoisesti vuosittain sijoitetaan 52 euroa pörssi-indeksiin.

## Tuotot

### Lotto

Lotosta voi viikottain voittaa päävoittona satunnaisesti 1,2,3,...,10 miljoonaa, tai pienempinä voittoina:

* 6 oikein: 2000 euroa
* 5 oikein: 200 euroa
* 4 oikein: 10 euroa

### Sijoittaminen

Sijoittamisen vuosituotot määräytyvät t-jakauman mukaan (df = 3, ka = 1.07, sd = 0.03).
Mikäli vuosituottojakauma kuitenkin menee pakkaselle asetetaan vuosituotoksi -80 %.

## Simulaatio

Lasketaan voittojakaumat 10 000 elämän ajalta Monte Carlo -simulaationa lottoamiselle ja sijoittamiselle.
