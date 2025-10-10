# 💡 Referência Rápida: Funções Avançadas da Linguagem M (Power Query)

# 1.  Funções de Tabela (Table.*)

Funções de tabela são o coração do Power Query — e a interface gráfica, GUI, cobre só uma parte dos recursos.

## 💪 Avançadas e pouco acessíveis via GUI:

- **`Table.AddIndexColumn`** → cria índice (muito usado pra ordenar e mesclar manualmente).

- **`Table.Buffer`** → **Materialização de Dados (Performance)**: "trava" a tabela na memória. Essencial para evitar recálculo de etapas pesadas, funcionando como um cache temporário.

- **`Table.Group`** → agrupa e permite cálculos customizados (como List.Max, List.Sum etc).

- **`Table.Combine`** → junta várias tabelas de uma lista (ex: várias abas de Excel).

- **`Table.AddColumn`** com `each` personalizado → cria colunas calculadas além do GUI.

- **`Table.RemoveRowsWithErrors`** → remove linhas problemáticas.

- **`Table.ExpandRecordColumn` / `Table.ExpandListColumn`** → manipula JSONs e colunas aninhadas (quase nunca via GUI).

<br>

---

> 🧠 NOTA:
O combo `Table.AddColumn` + `each` + `[coluna]` é o equivalente do SELECT ... AS do SQL.
---

<br>


# 2. Funções de Lista (List.*)

As listas se comportam como arrays do M.
A interface quase não toca nelas, mas elas resolvem muita coisa que GUI não alcança.

**Exemplos úteis:**

- **`List.Distinct`** → valores únicos.

- **`List.Sort`, `List.Max`, `List.Min`** → autoexplicativos.

- **`List.PositionOf`** → acha posição de um item (tipo indexOf).

- **`List.Accumulate`** → o "reduce" do M (poderosíssimo pra somar, concatenar, contar).

- **`List.Generate`** → cria listas dinamicamente (ótimo pra loops, datas, ranges).

<br>

>🧠 Dica:
É possível converter tabela → lista com `Table.Column` (MinhaTabela, "NomeColuna").

<br>

# 3. Funções de Texto (Text.*)

A interface tem poucas opções, mas o M tem um arsenal.

**Principais:**

- **`Text.Contains`, `Text.StartsWith`, `Text.EndsWith`** → filtros avançados.

- **`Text.Split`, `Text.Middle`, `Text.BeforeDelimiter`, `Text.AfterDelimiter`** → manipulação tipo “substring”.

- **`Text.PadStart`, `Text.PadEnd`** → preencher com zeros, por exemplo.

- **`Text.Combine`** → concatenação de listas de texto.

- **`Text.Replace e Text.RegexReplace`** → o regex é ouro (só via código).

<br>

# 4. Funções de Número (Number.*)

Pouco glamourosas, mas essenciais pra limpeza e validação.

**Principais:**

- **`Number.Round`, `Number.RoundUp`, `Number.RoundDown`**

- **`Number.FromText`** (quando números vêm como texto)

- **`Number.IsNaN`, `Number.IsNull`**

- **`Number.Mod`, `Number.Power`**, etc.

<br>

# 5. Funções de Data e Hora (Date.*, Time.*, DateTime.*)

Algumas dessas funções só estão disponíveis no código M, sem recursos na interface gráfica.

**Exemplos:**

- **`Date.AddDays`, `Date.AddMonths`, `Date.AddYears`**

- **`Date.DayOfWeekName`, `Date.WeekOfYear`**

- **`Date.FromText`, `DateTime.LocalNow`**

- **`Date.IsInCurrentMonth`, `Date.IsInPreviousMonth`**, etc.

<br>

>💡 Usos clássicos: colunas de períodos automáticos, faixas de tempo, comparações dinâmicas.

<br>

# 6. Funções de Registro (Record.*)

Essenciais pra manipular linhas ou JSONs.

**Mais úteis:**

- **`Record.Field`** → acessa valor específico de um registro.

- **`Record.AddField`, `Record.RemoveFields`** → manipula colunas de uma única linha.

- **`Record.ToTable e Table.ToRecords`** → alterna formato tabela <-> registro.

<br>

>🧠 Muito usado em APIs e colunas aninhadas (tipo “detalhes de um pedido”).

<br>

# 7. Funções de Transformação e Estrutura

As “fora do radar” da interface.

- **`Table.TransformColumns`** → aplica função customizada em várias colunas.

- **`Table.Pivot e Table.Unpivot`** → pivotagem customizada (a GUI tem limites).

- **`Table.NestedJoin`** → junção sem expandir, mantendo aninhado.

- **`Table.DemoteHeaders` / `Table.PromoteHeaders`**

- **`Table.FromRecords` / `Table.ToRecords`**

<br>

# 8. Funções de Meta e Avaliação

Essas não aparecem nunca na interface gráfica, mas são essenciais pra quem quer performance.

- **`Value.Is`, `Value.Type`** → checam tipo de dado.

- **`Type.Is`, `Type.ForFunction`, `Type.AddTableKey`**

- **`Expression.Evaluate`** → executa código M dinâmico (tipo eval).

- **`Diagnostics.Trace`** → debug de transformações.

- **`Error.Record`** → gera erros customizados.

<br>

# 9. Estrutura de uma Fórmula M (Esqueleto)

Toda consulta M segue uma estrutura básica com blocos `let ... in ...`.

```m
let
    // 1️⃣ Fonte de dados (entrada)
    Fonte = Excel.Workbook(File.Contents("Caminho/Arquivo.xlsx"), null, true),

    // 2️⃣ Etapas de transformação (cada uma usa a anterior como base)
    #"Cabeçalhos Promovidos" = Table.PromoteHeaders(Fonte, [PromoteAllScalars=true]),
    #"Colunas Removidas" = Table.RemoveColumns(#"Cabeçalhos Promovidos", {"ColunaInútil"}),
    #"Tipos Alterados" = Table.TransformColumnTypes(#"Colunas Removidas", {
        {"Data", type date},
        {"Valor", type number}
    }),
    #"Coluna Calculada" = Table.AddColumn(#"Tipos Alterados", "Total", each [Qtd] * [Preço]),

    // 3️⃣ Etapa final (geralmente a última transformação)
    #"Resultado Final" = #"Coluna Calculada"
in
    #"Resultado Final"
```
<br>

## 💡 Estrutura padrão das etapas

|Padrão|Descrição|Exemplo|
|:---|:---|:---|
|`#"Nome da Etapa"`|Nome legível da transformação|`#"Linhas Filtradas"`|
|`Table.AlgumaCoisa`|Função aplicada à tabela|`Table.RemoveColumns`|
|`#“Etapa Anterior”`|Entrada da função|`Table.TransformColumnTypes(#"Colunas Removidas", {...})`|

<br>

## ⚙️ Estrutura interna com each, let e in
```
each [colunaA] * 0.1
```

➡️ **`each` cria uma função anônima aplicada a cada linha da tabela (como o `for row` do SQL).**
```
each 
    let 
        imposto = [Preço] * 0.2,
        custo = [CustoFixo] + imposto
    in 
        custo
```
➡️ **Esse `let` ... in interno funciona como subconsulta: você cria variáveis temporárias pra linha atual antes de retornar o resultado.**

## 🧠 Regras rápidas de sintaxe

- { } → acessam linhas (ex: MinhaTabela{0})

- [ ] → acessam colunas ou campos (ex: [Preço])

- ( ) → delimitam funções e argumentos (ex: Table.AddColumn(...))

- #"" → usado pra nomes com espaços ou acentos
ex: #"Receita por produtos (BRL)"

## 🪄 Resumo mental:

- let = “defino as etapas”

- in = “retorno o resultado final”

- each = “para cada linha”

- #"" = “nome com espaço”

- {} = “pego linha”

- [] = “pego coluna”

<br>

# 10. Exemplos Práticos Rápidos

Três exemplos diretos e comentados pra lembrar a estrutura sem precisar abrir a cabeça da consulta antiga.  

---

## 1. Criar Coluna Calculada

```m
let
    Fonte = MinhaTabela,
    #"Coluna Lucro" = Table.AddColumn(
        Fonte,
        "Lucro",
        each [Receita] - [Custo],
        type number
    )
in
    #"Coluna Lucro"

```

>🧠 NOTA: `each` percorre linha a linha.
Seia o equivalente de `SELECT Receita - Custo AS Lucro` no SQL.

## 2. Filtrar Linhas com Condição
```
let
    Fonte = MinhaTabela,
    #"Filtradas" = Table.SelectRows(
        Fonte,
        each [Canal] = "Mercado Livre" and [Estado] = "SP"
    )
in
    #"Filtradas"
```

>🧠 NOTA: Usa `and` / `or` como operadores lógicos.
É possível combinar quantas condições quiser.

## 3. Agrupar e Somar Valores

```
let
    Fonte = MinhaTabela,
    #"Agrupadas" = Table.Group(
        Fonte,
        {"Categoria"},
        {{"Total Receita", each List.Sum([Receita]), type number}}
    )
in
    #"Agrupadas"
```
>🧠 NOTA: `Table.Group` = `GROUP BY` do SQL.
Dentro, usamos funções de lista (ex: `List.Sum`, `List.Max`, `List.Min`).

## ⚡ Extra: Combinar várias tabelas de uma pasta
```
let
    Fonte = Folder.Files("C:\Relatorios"),
    #"Planilhas Importadas" = Table.Combine(
        List.Transform(Fonte[Content], each Excel.Workbook(_){0}[Data])
    )
in
    #"Planilhas Importadas"
```
>🧠 NOTA: Esse padrão é o “loop” do M — percorre todos os arquivos e empilha tudo num só.

<br>

## 🔍 Resumo express:

- Table.AddColumn → cria novas colunas.

- Table.SelectRows → filtra.

- Table.Group → agrega.

- List.* dentro de Table.Group = função agregadora.

- List.Transform = loop funcional (substitui “for”).

- #"" = nomes com espaço, sempre.
