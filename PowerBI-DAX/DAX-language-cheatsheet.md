# ⚡ Guia Rápido DAX — Data Analysis Expressions
💡 O que é DAX e por que ele é essencial?

DAX (Data Analysis Expressions) é a linguagem usada no Power BI, Excel (Power Pivot) e Analysis Services para criar medidas, colunas calculadas e tabelas virtuais.

Se o Power Query (M) prepara os dados, <br>👉 o DAX analisa e agrega os dados já carregados no modelo.

<br>

>🧠 Analogia simples:
> - Power Query (M): limpa, estrutura e modela dados.
> - DAX: calcula, analisa e entrega métricas dinâmicas no relatório.

## 1. Tipos de Cálculos em DAX

|Tipo|descrição|Exemplo|Onde usar|
|:---|:---|:---|:---|
|Coluna Calculada|É avaliada linha a linha (como fórmula no Excel).|Vendas[Lucro] = Vendas[Receita] - Vendas[Custo]|Quando o valor precisa ser armazenado por linha.|
|Medida|É avaliada sob contexto (filtros do relatório).|Total Vendas = SUM(Vendas[Receita])|Dashboards e KPIs dinâmicos.|
|Tabela Calculada|Cria uma tabela derivada de outra.|Top5Produtos = TOPN(5, SUMMARIZE(Vendas, Produtos[Nome], "Total", SUM(Vendas[Valor])))|Rankings, comparações e análises de cenários.|

## 2. Principais Categorias de Funções DAX
### 📊 Funções de Agregação

Usadas para somar, contar e agregar valores.
| Função            | Descrição                   | Exemplo                            |
| :---------------- | :-------------------------- | :--------------------------------- |
| `SUM()`           | Soma valores numéricos.     | `SUM(Vendas[Valor])`               |
| `AVERAGE()`       | Média simples.              | `AVERAGE(Vendas[Lucro])`           |
| `COUNTROWS()`     | Conta linhas de uma tabela. | `COUNTROWS(Clientes)`              |
| `DISTINCTCOUNT()` | Conta valores únicos.       | `DISTINCTCOUNT(Vendas[ClienteID])` |
| `MAX()`, `MIN()`  | Maior e menor valor.        | `MAX(Vendas[Data])`                |

---
### 🧠 Funções de Filtro e Contexto
<br>

| Função            | Descrição                                            | Exemplo                                                               |
| :---------------- | :--------------------------------------------------- | :-------------------------------------------------------------------- |
| `CALCULATE()`     | Reavalia a medida sob novo contexto de filtro.       | `CALCULATE(SUM(Vendas[Valor]), Vendas[Categoria] = "Online")`         |
| `FILTER()`        | Cria filtros dinâmicos para uso dentro de CALCULATE. | `FILTER(Vendas, Vendas[Valor] > 1000)`                                |
| `ALL()`           | Remove filtros do contexto atual.                    | `CALCULATE(SUM(Vendas[Valor]), ALL(Vendas))`                          |
| `ALLEXCEPT()`     | Remove todos os filtros, exceto os informados.       | `CALCULATE(SUM(Vendas[Valor]), ALLEXCEPT(Vendas, Vendas[Categoria]))` |
| `REMOVEFILTERS()` | Versão moderna de `ALL`.                             | `CALCULATE(SUM(Vendas[Lucro]), REMOVEFILTERS(Vendas[Data]))`          |

<br>

>💬 Dica: CALCULATE() é a função mais poderosa (e complexa) do DAX.
Ela permite criar medidas condicionais, comparações e cálculos percentuais.
---

### ⏱️ Funções de Inteligência de Tempo

Usadas em qualquer dashboard financeiro ou de vendas.
| Função                 | Descrição                                  | Exemplo                                                                   |
| :--------------------- | :----------------------------------------- | :------------------------------------------------------------------------ |
| `TOTALYTD()`           | Soma valores até a data atual no ano.      | `TOTALYTD(SUM(Vendas[Valor]), Datas[Data])`                               |
| `SAMEPERIODLASTYEAR()` | Retorna o mesmo período do ano anterior.   | `CALCULATE(SUM(Vendas[Valor]), SAMEPERIODLASTYEAR(Datas[Data]))`          |
| `DATEADD()`            | Avança ou retrocede datas.                 | `DATEADD(Datas[Data], -1, MONTH)`                                         |
| `PARALLELPERIOD()`     | Período paralelo (ex: trimestre anterior). | `CALCULATE(SUM(Vendas[Valor]), PARALLELPERIOD(Datas[Data], -1, QUARTER))` |

<br>

> ⚙️ Requisito: todas essas funções dependem de uma tabela calendário bem construída com relação de 1:N com a tabela de fatos.
---
### 🎯 Funções Lógicas e Condicionais
| Função                   | Descrição                | Exemplo                                                   |
| :----------------------- | :----------------------- | :-------------------------------------------------------- |
| `IF()`                   | Condicional simples.     | `IF(Vendas[Lucro] > 0, "Lucro", "Prejuízo")`              |
| `SWITCH()`               | Substitui múltiplos IFs. | `SWITCH(Vendas[Canal], "Online", 1, "Loja", 2, "Outros")` |
| `AND()`, `OR()`, `NOT()` | Operadores lógicos.      | `IF(AND([Lucro] > 0, [Margem] > 0.2), "OK", "Verificar")` |
---
### 🧮 Funções de Tabela e Contexto de Linha
| Função           | Descrição                                         | Exemplo                                                               |
| :--------------- | :------------------------------------------------ | :-------------------------------------------------------------------- |
| `RELATED()`      | Busca valor em tabela relacionada (tipo VLOOKUP). | `RELATED(Clientes[Nome])`                                             |
| `RELATEDTABLE()` | Retorna tabela relacionada (1:N).                 | `COUNTROWS(RELATEDTABLE(Vendas))`                                     |
| `VALUES()`       | Retorna valores distintos de uma coluna.          | `VALUES(Clientes[Segmento])`                                          |
| `SUMMARIZE()`    | Agrupa dados (tipo GROUP BY).                     | `SUMMARIZE(Vendas, Produtos[Categoria], "Total", SUM(Vendas[Valor]))` |
| `ADDCOLUMNS()`   | Cria nova coluna em uma tabela virtual.           | `ADDCOLUMNS(Produtos, "TotalVendas", [Total Vendas])`                 |
---
##  3. Padrões DAX mais usados em BI
| Cenário                             | Medida DAX                                                                      | Explicação                                     |
| :---------------------------------- | :------------------------------------------------------------------------------ | :--------------------------------------------- |
| **Lucro Total**                     | `Lucro = SUM(Vendas[Receita]) - SUM(Vendas[Custo])`                             | Diferença entre receita e custo.               |
| **Margem de Lucro %**               | `Margem = DIVIDE([Lucro], [Receita])`                                           | DIVIDE evita erro de divisão por zero.         |
| **Receita YTD (Ano até o momento)** | `Receita YTD = TOTALYTD([Receita], Datas[Data])`                                | Acumula até a data atual do ano.               |
| **Comparativo com Ano Anterior**    | `Receita LY = CALCULATE([Receita], SAMEPERIODLASTYEAR(Datas[Data]))`            | Traz o valor do mesmo período do ano anterior. |
| **Crescimento % Ano a Ano**         | `Crescimento % = DIVIDE([Receita] - [Receita LY], [Receita LY])`                | Percentual de variação entre anos.             |
| **Top N Produtos**                  | `Top5Vendas = TOPN(5, SUMMARIZE(Produtos, Produtos[Nome], "Total", [Receita]))` | Ranking dos 5 produtos mais vendidos.          |
---
## 4. Dicas Profissionais

✅ Sempre crie uma Tabela Calendário:
```
Calendario = CALENDAR(MIN(Vendas[Data]), MAX(Vendas[Data]))
```
✅ Evite colunas calculadas desnecessárias:
Prefira medidas — elas são calculadas sob demanda, não armazenadas em disco.

✅ Nomeie medidas com clareza:
[Total Receita], [Lucro Bruto], [Crescimento %] → boas práticas  profissionais.

✅ Organize medidas em pastas:
Em “Modelagem > Exibir como Pasta de Medidas” no Power BI.

✅ Verifique o contexto:

- Contexto de linha → cálculo por registro (como coluna).
- Contexto de filtro → cálculo agregado (como medida).

<br>

> Saber alternar entre eles é o divisor entre um “usuário de BI” e um “analista de BI”.
---
## 5. Mental Map DAX
```dax
Tabelas de Fato + Dimensões
       │
       ▼
Power BI Model (relacionamentos)
       │
       ▼
Medidas DAX (CALCULATE, FILTER, SUMX, etc.)
       │
       ▼
Dashboards dinâmicos e interativos

```