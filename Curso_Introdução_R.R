##########################################################################################
# PET Floresta
# Oficina de Introdução ao R
# Jorge Makhlouta Alonso
# 04/09/2023
##########################################################################################

###### Objetivo: Apresentar o software R aos participantes do curso, demonstrar sua aplicação 
# para análises estatísticas de dados de inventário florestal e implementar a adaptação de 
# códigos para realizar análises semelhantes às apresentadas.

###### Conteúdo do curso: 1) Primeiros passos; 2) Operações básicas; 
# 3) Pacotes, funções e argumentos; 4) Noções de análise exploratória; 
# 5) Estatística descritiva; 6) Tabelas e gráficos; 7) Noções sobre associação entre variáveis.

##### Primeiras observações

# No R o hashtag é utilizado para identificar uma linha de texto.
# Se começarmos a linha sem o # essa será uma linha de código.
# Rode o código abaixo como exemplo (pressione crtl + enter na linha abaixo):
print("Hello, World")

# Agora tente rodar o código dessa maneira:
# print("Hello, World")

# E dessa:
Hello, World

# O que aconteceu de diferente em cada caso?

# Podemos utilizar o # após um código para incluir observações:
print("Hello, World") # É uma tradição utilizar esse código como boas-vindas a uma linguagem de programação.

##### Operações básicas de cálculo
1 + 2 # Adição
4 - 2 # Subtração
3 * 5 # Multiplicação
10 / 2 # Divisão
3 ^ 2 # Exponencial

##### Operadores lógicos
1 == 1 # Igual
1 == 2 
1 != 1 # Diferente
1 > 3 # Maior
1 < 3 # Menor
1 <= 1 # Menor ou igual
1 >= 3 # Maior ou igual

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
# florestais, além de algumas funções específicas para essa finalidade.

### Carregando um conjunto de dados do pacote
data("exfm20")
# O conjunto de dados "exfm20" é disponibilizado no pacote forestmangr. 
# Ele contém dados de um inventário em floresta nativa.
# Utilizamos a função data para carregar os dados.

## Neste curso faremos as demonstrações e práticas a partir de um conjunto de dados...
# disponibilizado em um pacote do R. Na prática, para fazer análises em dados de um experimento...
# nosso, precisariámos utilizar funções que carreguem e leiam planilhas no Excel ou outros tipos de...
# arquivo. 

### Resumindo o conjunto de dados
summary(exfm20)
# Com a função summary conseguimos ter uma visão geral dos dados.
# O que vocês conseguem observar?

### Criando vetores
dados <- exfm20
# No R utilizamos vetores (ou objetos) para armazenar dados.
# Com o código acima, criamos um vetor como nome mais fácil para trabalhar os dados.

### Filtrando dados
dados_lecythis <- subset(dados, scientific.name == "Lecythis idatimon")
# Utilizamos a função subset para filtrar os dados
# Dentro das funções no R podemos utilizar argumentos para especificar o que queremos fazer
# O argumento select foi utilizado para filtrar os dados pela coluna scientific.name
# E para células com o nível "Lecythis idatimon" dentro dessa coluna

### Outros tipos de filtros
dados$dbh # Coluna
dados[,7] # A mesma coisa de outra maneira
dados[7,] # Linha
dados[7, 7] # Célula

### Prática: 

# Como podemos filtrar os dados para a espécie Eschweilera coriacea?
dados_eschweilera <- subset(dados, scientific.name == "Eschweilera coriacea")

# E para a família Fabaceae?
dados_fabaceae <- subset(dados, family == "Fabaceae")

##### Explorando os dados

### Vamos rodar novamente a função summary
summary(dados)

# Podemos ver que existem alguns NAs entre os dados.
# NA = not available // dados não existentes.
# Algumas funções não vão rodar ou vão rodar errado se não tratarmos os dados.

# Temos duas opções:
# Podemos transformar os NAs pelo valor da média (ou outra medida) de cada variável
# Podemos retirar essas linha do conjunto de dados.

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
# ... por exemplo, 10 cm de DAP e 3 m de altura.

# Por via das dúvidas podemos checar as células onde temos observações, por exemplo...
# ... com altura menor que 4 m.
which(dados_pp$Htot < 4.0)

# Podemos observar linhas para conferir os valores das outras variáveis
dados_pp[1206,]
dados_pp[1208,]
# E aí? O que vocês acham?

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
# ... combinar funções para calcular:
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
