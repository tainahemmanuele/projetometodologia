library(tidyverse)
library(rvest)
library(stringr)
library(dplyr)
library(magrittr)

avaliacoes <- read.csv('avaliacoes-20181030.csv')

glimpse(avaliacoes)

avaliacoes <- avaliacoes %>% select(matricula = "Matr√.cula", 
                                    id.reclamacao = "ID.da.reclama√.√.o", 
                                    avaliacao = "Grau.de.insatisfa√.√.o")
glimpse(avaliacoes)

avaliacoes <- avaliacoes %>% select(id.reclamacao, avaliacao) %>% 
              group_by(id.reclamacao) %>% 
              summarise(insatisfacao = median(avaliacao), 
                        avaliadores = n(),
                        range.avaliacoes = (max(avaliacao) - min(avaliacao)))

#quantas avalia√ß√µes tem discordancia de avalia√ß√£o maior que 2? Ser√° que devemos confiar nessas avalia√ß√µes?
avaliacoes %>% filter(range.avaliacoes > 2) 


reclamacoes.avaliadas <- read.csv("20181610-reclamacoes-selecionadas.csv")

names(reclamacoes.avaliadas)
names(avaliacoes)

reclamacoes <- left_join(reclamacoes.avaliadas, avaliacoes, 
                         by=c("ID" = "id.reclamacao"))

reclamacoes %>%  write.csv("reclamacoes-avaliadas-20180703.csv")


