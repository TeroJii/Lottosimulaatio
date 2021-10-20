# Lottosimulaatio
Simuloidaan tuottojakautumia pelatessa lottoa 50 vuoden ajan vs. sama sijoitettuna indeksiin.

## Sijoitetut rahat

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
Lisäksi keskimäärin joka 15. vuosi tapahtuu ns. pörssiromahdus, joka laskee jakauman keskiarvon 0.75 tasolle.

**Huom. jakauma ei täysin vastaa historiallisten tuottojen jakaumaa. Negatiivisen tuoton vuosia tulee simulaatiossa hieman harvemmin kuin pörssihistorian mukaan (nopealla googlauksella).

## Simulaatio

Lasketaan voittojakauma 10 000 ihmiselle 50 vuoden ajalta Monte Carlo -simulaationa lottoamis- ja sijoittamisstrategialla.
