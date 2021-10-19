## Lottosimulaatio

### Libraries ----------

library(tidyverse)
theme_set(theme_bw())

set.seed(555)

###Hinnat ja palkinnot###
rivin_hinta <- -1 #Euron rivi
yksi_oikein <- 0
kaksi_oikein <- 0
kolme_oikein <- 0
nelja_oikein <- 10
viisi_oikein <- 200
kuusi_oikein <- 2000
seitseman_oikein <- 10^7 #pohjasumma alempana vaihtuu viikottain


voitot <- c(rivin_hinta, #nolla oikein
            rivin_hinta + yksi_oikein,
            rivin_hinta + kaksi_oikein,
            rivin_hinta + kolme_oikein,
            rivin_hinta + nelja_oikein,
            rivin_hinta + viisi_oikein,
            rivin_hinta + kuusi_oikein,
            rivin_hinta + seitseman_oikein
            )

### Rivejä elämän aikana ###
n <- 52*50 #rivi viikossa, 50 vuoden ajan

lottoa.f <- function(){
  #Rivi jota pelataan koko ikä
  numerot <- sample(1:40, size = 7)
  #Voitot eliniän ajalta
  S <- replicate(n, {
    viikonrivi <- sample(1:40, size = 7)
    viikonpotti <- sample(seq(from = 10^6, to = 10^7, by = 10^6), 1) #miljoonasta kymmenneen
    oikeita <- sum(numerot %in% viikonrivi)
    voitot[8] <- (rivin_hinta + viikonpotti) # Päävoitto vaihtuu viikottain
    voitot[1+oikeita]
  })
  return(sum(S)) #voitot elämän aikana
}

### Samat rahat pörssiin ##


indeksiin.f <- function(){
  vuosisumma <- 52
  rahastokulut <- 0.99 # 1% hallinnointikulu
  #Vuosituotot
  S <- replicate(50, {
    vuosituotto <- sample(c(1.07,0.75), prob = c(14/15,1/15), size = 1) + #perustaso + romahdus noin joka 15. vuosi
      rt(1,df = 3)*0.03 # t-jakauma ka = 1.07, sd = 0.03 = Satunnaisvaihtelu vuosittain
  })
  for(i in 1:50){
    if(S[i] <0){ # T-jakaumasta voi tulla negatiivisia arvoja
      S[i] <- 0.2 # Vuosituotto tällöin -80%
    }
    if(i>1){
      summa <- (summa + vuosisumma)*rahastokulut*S[i]
    }else{
      summa <- vuosisumma*rahastokulut*S[i]
    }
  }
  return(summa)
}

### Pelataan lottoa 10 000 elämän ajan
#This may take a while
S2 <- replicate(n = 10000,{
  lottoa.f()
})


### Sijoitetaan indeksiin 10 000 elämän ajan

S3 <- replicate(n = 10000,{
  indeksiin.f()
})

### Kuvaajia -----------

#Voittojen jakauma Lotto
pl1 <- ggplot(data = data.frame(S2), aes(x=S2)) +
  geom_histogram(color = "black", fill = "red", binwidth = 100) +
  scale_y_log10() +
  geom_vline(xintercept = c(0), color = "red", lty = 2) +
  labs(x = "Voitot 50 vuoden lottoamisen jälkeen (€)") +
  ggtitle("Monte Carlo -simulaatio, jossa lottoa pelattu samalla rivillä 50 vuotta", 
          subtitle = "Simuloitujen 10000 elämän voittojakauma")

#Voittojen jakauma Indeksi
pl2 <- ggplot(data = data.frame(S3), aes(x=S3)) +
  geom_histogram(color = "black", fill = "red") +
  geom_vline(xintercept = 52*50, color = "red", lty = 2) + #sijoitettu paaoma
  labs(x = "Voitot 50 vuoden indeksiin sijoittamisen jälkeen (€)") +
  ggtitle("Monte Carlo -simulaatio, jossa sijoitettu indeksiin 50 vuotta", 
          subtitle = "Simuloitujen 10000 elämän voittojakauma (vuosikulut 1%)")


#ggsave(filename = "IndeksisijoittamisenJakauma.jpg", plot = pl2, device = "jpg", width = 6, height = 4, units = "in")

#Lotto lineaarinen y-akseli
pl3 <- ggplot(data = data.frame(S2), aes(x=S2)) +
  geom_histogram(color = "black", fill = "red", binwidth = 100) +
  labs(x = "Voitot 50 vuoden lottoamisen jälkeen (€)") +
  ggtitle("Monte Carlo -simulaatio, jossa lottoa pelattu 50 vuotta", 
          subtitle = "Simuloitujen 10000 elämän voittojakauma")

#ggsave(filename = "JakaumaNollanTuntumassa.jpg", plot = pl3, device = "jpg", width = 6, height = 4, units = "in")

df <- data.frame(lotto = S2, indeksi = S3) %>% 
  pivot_longer(cols = everything(), names_to = "kohde", values_to = "arvo") %>% 
  group_by(kohde) %>% 
  summarize(keskiarvo = mean(arvo), 
            mediaani = median(arvo),
            minimi = min(arvo),
            maksimi = max(arvo))

#write.csv2(df, file = "Simulaatiotuotot.csv", row.names = FALSE)
