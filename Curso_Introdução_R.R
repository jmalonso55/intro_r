##########################################################################################
# Oficina de Introdução ao R
# Jorge Makhlouta Alonso
# 04/09/2023 - atualizado em 22/05/2024
##########################################################################################

###### Objetivo: Apresentar o software R aos participantes do curso, demonstrar sua aplicação 
# para análises estatísticas de dados de inventário florestal e implementar a adaptação de 
# códigos para realizar análises semelhantes às apresentadas.

###### Conteúdo do curso: 1) Primeiros passos; 2) Operações básicas; 
# 3) Pacotes, funções e argumentos; 4) Noções de análise exploratória; 
# 5) Estatística descritiva; 6) Tabelas e gráficos; 7) Noções sobre associação entre variáveis.

##### Primeiras observações

# No R o hashtag é utilizado para identificar uma linha de texto.
# Se começarmos a linha sem o "#" essa será uma linha de código.
# Rode o código abaixo como exemplo (pressione crtl + enter na linha abaixo):
print("Hello, World")

# Agora tente rodar o código dessa maneira:
# print("Hello, World")

# E dessa:
Hello, World

# E mais essa:
"Hello, World"

# O que aconteceu de diferente em cada caso?

## OBS: Quando queremos que o R leia texto ou caracteres, devemos colocar eles entre aspas.

# Podemos utilizar o "#" após um código para incluir observações:
print("Hello, World") # É uma tradição utilizar esse código como boas-vindas a uma linguagem de programação.

##### Operações básicas de cálculo
1 + 2 # Adição
4 - 2 # Subtração
3 * 5 # Multiplicação
10 / 2 # Divisão
3 ^ 2 # Exponencial

# Podemos combinar essas operações para fazer cálculos mais complexos.
# Utilize parênteses para que o cálculo seja feito na sequência correta.
# Exemplo:
(2 * (45 + 57)) / (4^3)

##### Operadores lógicos
1 == 1 # Igual
1 == 2 
1 != 1 # Diferente
1 > 3 # Maior
1 < 3 # Menor
1 <= 1 # Menor ou igual
1 >= 3 # Maior ou igual

# Podemos combinar as operação de cálculo com as lógicas:
(2 * (45 + 57)) / (4^3) > 3

### Prática:

# Um carro percorreu uma distância de 120 km em 90 minutos. Calcule sua velocidade em km/h.
120/(90/60)

# Sabendo que o limite de velocidade dessa rodovia é de 90 km/h, demonstre com um operador 
# lógico se o limite foi ou não respeitado.
120/(90/60) >= 90
80 >= 90

##### Pacotes, funções e argumentos

### Instalando pacotes
install.packages("forestmangr")
# No R utilizamos funções para realizar as tarefas que desejamos.
# Por exemplo, a função install.packages é utilizada para instalar pacotes.
# Os pacotes são como "expansões" do R contendo novas funções, bases de dados, etc.

### Carregando um pacote
library(forestmangr)

# Após a instalação de um pacote e sempre que se desejarmos utilizar suas funcionalidades...
# temos que carregá-lo.
# A função library ou a função require podem ser utilizadas para essa finalidade.
# Neste caso, estamos carregando o pacote "forestmangr" que contém dados de inventários...
# florestais, além de algumas funções específicas para análise desse tipo de dado.

# Pedindo ajuda:
help(package = "forestmangr")
# Vemos as funções que existem dentro pacote, bases de dados etc.

### Carregando um conjunto de dados do pacote
data("exfm20")
# O conjunto de dados "exfm20" é disponibilizado no pacote forestmangr. 
# Ele contém dados de um inventário em floresta nativa.
# Utilizamos a função data para carregar os dados.

# Para entender melhor nosso conjunto de dados:
help(exfm20)

# Equivalente a:
?exfm20

## Neste curso faremos as demonstrações e práticas a partir de um conjunto de dados...
# disponibilizado em um pacote do R. Na prática, para fazer análises em dados de um experimento...
# nosso, precisariámos utilizar funções que carreguem e leiam planilhas no Excel ou outros tipos de...
# arquivo. 

## Antes de proceder é importante conhecer alguns termos:
# Observações: são os seus indivíduos ou unidades experimentais. Devem ser colocados...
# na linha das tabelas de dados.
# Variáveis: são as medidas ou informações que você coletou de cada observação. Devem...
# ser colocadas nas colunas das tabelas de dados.
# Células: o cruzamento de uma coluna com uma linha. Ou seja, onde eu terei o valor ou...
# categoria de uma variável "x" para uma observação "n".
# Data frame: tabela estruturada com observações nas linhas e variáveis nas colunas.

# Vamos ver esses conceitos nos dados que acabamos de carregar:
View(exfm20)

# Temos 12.295 linhas correspondentes às árvores amostradas (observações) e...
# 18 colunas que são as variáveis mensuradas ou informações coletadas.

### Criando objetos
# No R utilizamos objetos (ou vetores) para armazenar dados.
# Vamos ver um exemplo com os cálculos que fizemos antes:
conta <- (2 * (45 + 57)) / (4^3)
resultado <- 3.1875
conta == resultado

## Para deixar o código mais claro utilizamos a seta (<-).
# Ela pode ser formada digitando "<" e depois "-" ou pelo atalho alt + -.
# Poderiámos ter utilizado o sinal de igual (=) ao invés da seta.
conta2 = (2 * (45 + 57)) / (4^3)
resultado2 = 3.1875
conta2 == resultado2
# Veja como o R processa de forma diferente "=" e "==". 
# Mais adiante veremos porque é mais claro utilizar "<-" do que "=" para criar objetos.

# Podemos ainda reescrever objetos:
conta <- c((2+2), (2+3), (2+4), (2+5))
# Utilizamos a função "c" para passar ao R um conjunto de valores dentre de um objeto.
# Olha o que aconteceria se a gente não tivesse feito isso:
conta <- ((2+2), (2+3), (2+4), (2+5))
conta <- (4, 5, 6, 7)

# Vamos criar mais um objeto para vermos novos exemplos:
exemplo <- c(1, 3, 5, 7)

# Por fim, conseguimos fazer operações também com objetos com mais de um valor e entre eles:
2 * conta
conta > 5
conta + exemplo
conta >= exemplo

# Com o código abaixo, criamos um objeto como nome mais fácil para trabalhar os nossos dados.
dados <- exfm20
# Daqui para frente iremos digitar várias vezes o nome do nosso objeto e "dados" é mais...
# fácil de lembrar e digitar do que "exfm20".

### Prática

# Crie um objeto contendo os valores 2, 4, 6 e 8 e outro contendo a, b, c e d.
# Dica: lembre de usar aspas para caracteres.
objeto1 <- c(2, 4, 6, 8)
objeto2 <- c("a", "b", "c", "d")

# Some os dois objetos. O que aconteceu?
objeto1 + objeto2

### Resumindo o conjunto de dados
summary(dados)
# Com a função summary conseguimos ter uma visão geral dos dados.
# O que vocês conseguem observar?

# Aprofundando a questão das classes (ou tipos) de variáveis e objetos:
class(dados) # Veja que o R lê o objeto que contém nossos dados como um data frame.
class(conta) # Esse objeto ele leu como numeric.
class("a") # Agora como character
class(as.list(c("a", "b", "c"))) # Por fim, como uma lista.

## Sobre combinar funções:
# É muito comum aninhar funções (nesting), ou seja, combinar elas. Essa técnica pode ser...
# muito útil para resolvermos inúmeros problemas práticos que surgem ao analisar dados.
# No exemplo acima, demos à função "class" uma lista criada com a função "as.list" a partir...
# de um conjunto de categorias criado com a função "c". 
# Vamos dividir em passos o que foi feito:
c("a", "b", "c") # Criamos um conjunto com as categorias a, b e c
as.list(c("a", "b", "c")) # Criamos uma lista com três objetos a, b e c
lista <- as.list(c("a", "b", "c")) # Uma outra abordagem seria criar um objeto para essa lista
class(lista) # Chegamos ao mesmo resultado! Note como pode ser prático aninhar funções.

# Podemos ainda querer conhecer as classes de cada uma das nossas variáveis
str(exfm20)

## Algumas definições antes de prosseguir:
# Classe "Factor": atribuída a variáveis qualitativas nominais ou ordinais;
# Classe "int" (integer): atribuída a variáveis quantitativas discretas;
# Classe "num" (numeric): atribuída a variáveis quantitativas contínuas;
# Classe "logi" (logical): atribuída a uma variável contendo respostas lógicas (TRUE ou FALSE).
# Níveis (levels): são os valores ou categorias distintas que uma variável pode assumir.
# OBS: é válido saber que existem outras classes de variáveis e objetos, além das que observamos.

# Podemos converter alguns objetos e variáveis para outras classes:
fator <- factor(conta) # Transformamos o objeto numérico conta em fator
class(fator) # Verificamos se deu certo
numerico <- as.numeric(fator) # Transformamos ele de novo em numérico
class(numerico) # Verificamos se deu certo

## OBS: podemos usar, por exemplo, "factor" ou "as.factor" para fazer a primeira tarefa.
# A função "factor" em geral é utilizada para converter dados brutos à classe.
# A função "as.factor" em geral é utilizada para converter um objeto já existente.

### Prática

# Identifique a classe dos objetos que você criou na prática anterior
class(objeto1)
class(objeto2)

# Ou
str(objeto1)
str(objeto2)

# Crie um novo objeto contendo 1, 2, 3 e d. Identifique a classe dele.
objeto3 <- c(1, 2, 3, "d")
class(objeto3)

# Coverta ele em fator e verifique. 
# Use a função "levels" depois a "unique" para identificar seus níveis. Compare as duas.
objeto3 <- factor(objeto3)
class(objeto3)
levels(objeto3)
unique(objeto3)

### Estabelecendo argumentos dentro de funções

# Vamos utilizar como exemplo a função do R que cria dados aleatórios com distribuição normal.
# Primeiro vamos rodar ela e ver o que acontece:
rnorm(n = 10, mean = 5, sd = 1)
# Geramos 10 valores de uma distribuição normal com média 5 e desvio padrão 1.

# Agora vamos entender os argumentos dessa função:
help(rnorm)
# O argumento "n" corresponde ao número de observações;
# "mean corresponde a média da distribuição;
# "sd" corresponde ao desvio padrão.

# Podemos mudar esses argumentos para que a função nos retorne outro resultado.
# vamos agora gerar 20 observações com média 10 e desvio 2 (população fictícia com essa média e desvio).
# Vamos utilizar a função "set.seed" para garantir que os valores gerados sejam sempre iguais
set.seed(555)
rnorm(n = 20, mean = 10, sd = 2)

# Se colocarmos os argumentos na posição certa, não precisamos identificar eles na função:
set.seed(555)
rnorm(20, 10, 2)

# No entanto, se colocarmos fora de ordem...
set.seed(555)
rnorm(2, 20, 10)
# Geramos um resultado diferente do desejado.
# Temos duas observações a partir de uma população fictícia com média 20 e do desvio 10.

# Identificando os argumentos na função, podemos alterar sua ordem e teremos o resultado desejado:
set.seed(555)
rnorm(sd = 2, n = 20, mean = 10)

### Prática

# Rode o código rnorm(20, 10, 2) duas vezes sem utilizar a função "set.seed" antes.
# Agora rode duas vezes com o código set.seed(555) na linha anterior.
# O que aconteceu?

### Filtrando dados
dados_lecythis <- subset(x = dados, subset = scientific.name == "Lecythis idatimon")
# Utilizamos a função subset para filtrar os dados
# Dentro das funções no R podemos utilizar argumentos para especificar o que queremos fazer
# O argumento subset foi utilizado para filtrar os dados pela coluna scientific.name
# E para células com o nível "Lecythis idatimon" dentro dessa coluna

### Outros tipos de filtros
dados$dbh # Coluna
dados[,7] # A mesma coisa pela lógica de matriz - selecionando coluna 7
dados[7,] # Linha - selecionando linha 7
dados[7, 7] # Célula - selecionando o valor na linha 7 da coluna 7

## Entendendo os filtros pela lógica de matriz:
# Imagine a seguinte estrutura: dados[linhas, colunas]. A tabela inteira poderia ser...
# ilustrada da seguinte forma:
dados[1:12295, 1:18]
# Sendo assim, podemos selecionar mais de uma linha e ou coluna:
dados[5:15, 7:12]
# Filtramos as observações de 5 a 15 e as variáveis nas colunas de 7 a 12.

# Podemos ainda filtrar conjuntos de observações e variáveis dessa maneira:
dados[c(10, 100, 1000, 10000), c(7, 12, 16)]

### Prática: 

# Como podemos filtrar os dados para a espécie Eschweilera coriacea?
# Dica: Copie o código apresentado acima para realizar essa mesma tarefa para outra espécie...
# Modifique o código para executar o filtro solicitado. Apenas duas modificação será necessária.

# E para a família Fabaceae?

# Filtre os dados de dbh e Htot para as observações de 1250 a 1300.

##### Explorando os dados

### Vamos rodar novamente a função summary
summary(dados)

# Podemos ver que existem alguns NAs entre os dados.
# NA = not available // dados não existentes.
# Algumas funções não vão rodar ou vão rodar errado se não tratarmos os dados.

# Temos duas opções:
# Podemos transformar os NAs pelo valor da média (ou outra medida) de cada variável
# Podemos retirar essas linhas do conjunto de dados.

### Como estamos diante de dados com muitas observações e variáveis, vamos utilizar a segunda opção
dados_pp <- na.omit(dados)
# OBS: sempre que modificarmos a base de dados original, convém criar um novo objeto

# Verificamos novamente:
summary(dados_pp)

### Dados inconsistentes

# É possível observar que o diâmetro mínimo neste inventário foi de 10 cm.
# Por outro lado, vemos que existem árvores com altura de apenas 3 m.
# Um dado inconsistente seria aquele impossível de ser observado.
# Por exemplo, uma árvore com altura 0 ou -13.
# No caso observado acima, uma árvore que quebrou com a queda de outra pode ter...
# por exemplo, 10 cm de DAP e 3 m de altura.

# Por via das dúvidas podemos checar as células onde temos observações, por exemplo,...
# com altura menor que 4 m.
which(dados_pp$Htot < 4.0)

# Podemos observar linhas para conferir os valores das outras variáveis
dados_pp[1206, c(4, 7, 11, 12)]
dados_pp[1208, c(4, 7, 11, 12)]
# E aí? O que vocês acham?

# Observando dados incosistentes
which(dados_pp$Htot < dados_pp$Hcom)

# Retirando dados incosistentes
dados_pp2 <- subset(dados_pp, Htot > Hcom)

### Prática

# Faça essa operação para o vetor dados_lecythis.

##### Operações estatísticas básicas

### Calculando a média geral para o diâmetro
mean(dados_pp$dbh)

# Calculando a média do diâmetro em cada transecto
aggregate(dbh ~ transect, data = dados_pp, FUN = mean)

### Calculando o desvio padrão para o diâmetro
sd(dados_pp$dbh)

# Calculando o desvio padrão do diâmetro em cada transecto
aggregate(dbh ~ transect, data = dados_pp, FUN = sd)

### Não temos função para o coeficiente de variação no R, mas podemos...
# combinar funções para calcular:
(sd(dados_pp$dbh)/mean(dados_pp$dbh))*100

# Podemos ainda criar funções no R
cv <- function(x) (sd(x)/mean(x)) * 100

# E aplicá-las com outras funções:
aggregate(dbh ~ transect, data = dados_pp, FUN = cv)

### Prática

# Calcule essas mesmas medidas para a altura total.

##### Tabelas e gráficos de frequências

### Vamos carregar um pacote para facilitar a criação das tabelas
library(fdth)

### Tabela de frequências para a variável qualitativa família
tab_familia <- fdt_cat(dados_pp$family); tab_familia

### Tabela de frequências para a variável quantitativa diâmetro
tab_diametro <- fdt(dados_pp$dbh); tab_diametro

### Prática

# Faça a tabela para a variável nome científico.
# Use a função head para exibir os dados. O que aconteceu?

# Faça a tabela para a variável altura total.

### Gráfico de barras para a frequência das principais famílias

# O mais simples
barplot(head(tab_familia$f, 10))

# Função que abre uma janela externa onde o gráfico será plotado.
x11() 

# Alarga a margem da janela para o gráfico.
par(mar = c(7,10,4,2) + 0.1, family = "serif")

# Gráfico
barplot(head(tab_familia$f, 10), # Selecionamos as 10 famílias de maior frequência. 
        horiz = T, # Argumento para colocar as barras verticais ou horizontais. T e TRUE são equivalentes.
        xlab = "Frequências",  # Colocamos título do eixo x
        names.arg = c(head(tab_familia$Category, 10)), las = 2, # Colocamos os nomes das famílias em cada barra.
        cex = 1.3, cex.lab = 1.5, cex.axis = 1.2, col = heat.colors(10)) # Estabelecemos tamanho das letras
# e cores para as barras.

# Colocamos uma linha no eixo y.
abline(v = 0) 

# Retorna a margem ao normal.
par(mar = c(5,4,4,2) + 0.1) 

### Histograma para as classes de diâmetro

# O mais simples
x11()
hist(dados_pp$dbh)

# Função que abre uma janela externa onde o gráfico será plotado.
x11() 

# Gráfico
plot(tab_diametro, xlab = "Classes de diâmetro",ylab = "Frequências", # Determina a base de dados e títulos dos eixos 
     cex.axis = 0.9, cex.lab = 1.1, # Edita o tamanho das letras 
     col = c(rainbow(15))) # Edita as cores

### Prática

# Faça o mesmo gráfico de barras para as 10 principais espécies 

# Faça o histograma do diâmetro para Lecythis idatimon. Compare com o geral.

##### Avaliando graficamente tendência central e dispersão - boxplot

# O mais simples
x11()
boxplot(dados_pp$dbh)

# Plotando os dados de diâmetro por transecto 
x11()
boxplot(data = dados_pp, dbh ~ transect, xlab = "Transecto", ylab = "Diâmetro (cm)",
        col = terrain.colors(22))

### Prática

# Faça o boxplot para a altura nos transectos.

# Faça o boxplot do diâmetro para Lecythis idatimon nos transectos. Compare com o geral.

##### Associação entre variáveis

# Vamos explorar a associação entre diâmetro e altura

### Correlação linear
cor.test(dados_pp$dbh, dados_pp$Htot)

### Representação gráfica

# O mais simples
x11()
plot(data = dados_pp, Htot ~ dbh)

# Editando o gráfico
x11()
plot(data = dados_pp, Htot ~ dbh, xlab = "Diâmetro (cm)", ylab = "Altura (m)")

# Adicionando linha de tendência
abline(lm(data = dados_pp, Htot ~ dbh), col="darkred", lwd=3.5)

### Prática

# Avalie a associação entre o diâmetro e o volume.
