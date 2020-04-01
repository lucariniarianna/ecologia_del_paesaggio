# Analisi dei pattern legati ai punti

# installazione pacchetto spatstat
install.packages("spatstat")
# installazione pacchetto rgdal
install.packages("rgdal")

# richiamo i pacchetti precedentemente installati
library(ggplot2) # comando alternativo require(ggplot2)
library(spatstat)
library(rgdal)

# impostazione della working directory
setwd("~/Documents/lab")

# importazione dei dati
covid <- read.table("covid_agg.csv", head=T)  #head=T fa capire al sistema che si vuole aggiungere l'intestazione 

# richiamo le prime 6 righe della tabella
head(covid)

# creazione di un plot per iniziare a vedere la disposizione delle variabili
plot(covid$country,covid$cases) 
attach(covid) # modo alternativo per collegare una variabile al proprio dataset
plot(country,cases)

# con las si può modificare la modalità di visone dei labels
plot(covid$country,covid$cases,las=0) # parallel labels
plot(covid$country,covid$cases,las=1) # horizontal labels
plot(covid$country,covid$cases,las=2) # perpendicular labels
plot(covid$country,covid$cases,las=3) # vertical labels
#con ce.axis si controlla la grandezza dei labels
plot(covid$country,covid$cases,las=3,cex.lab=0.5, cex.axis=0.5) # vertical labels

# richiamo ggplot2
library(ggplot2)
# richiamo i dati nella libreria
data(mpg)
# mostro le prime 6 righe della tabella
head(mpg)
# 3 componenti fondamentali per un grafico:
# data
# aes -> estetica delle variabili
# tipo di geometria

# creo un plot che contenga queste 3 componenti
ggplot(mpg,aes(x=displ,y=hwy)) + geom_point()
ggplot(mpg,aes(x=displ,y=hwy)) + geom_line()
ggplot(mpg,aes(x=displ,y=hwy)) + geom_polygon()  #poco fruibile ai fini dei dati in questione

# creo un ggplot di covid
ggplot(covid,aes(x=lon,y=lat,size=cases)) + geom_point()

# vado ad analizzare il fattore densità
#richiamo la libreria in relazione ai dati covid
library(spatstat)
attach(covid)

# tramite la funzione ppp creo un nuovo dataset che mi interessa per l'analisi spaziale
covids <- ppp(lon, lat, c(-180,180), c(-90,90))

# semplifico la variabile della densità chiamandola d
d <- density(covids)

# plot di d
plot(d)

# si aggiungono i punti al plot
points(covids)

#save the .RData

setwd("~/Documents/lab")
load("point_pattern.RData")
ls()

# plot della mappa di densità
plot(d)
#palette
cl <- colorRampPalette(c("yellow","orange","red"))
plot(d, col= cl)

#plot della mappa della densità dal verde al blu
cl <- colorRampPalette(c("green","blue","violet"))
plot(d, col=cl)

# con points si possono inserire i punti spaziali definiti grazie alla funzione ppp
points(covids)

#
coastlines <- readOGR ("ne_10m_coastline.shp")
plot(coastlines, add=T)

#Exercise : plot della mappa di densità con una nuova colorazione e aggiunta delle coastlines
cl <- colorRampPalette(c("light blue","yellow","red")) (800)
plot(d, col=cl)
plot(coastlines, add=T, col="yellow")
