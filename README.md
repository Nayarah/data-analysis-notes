# 📊 Data Analysis Notes: Caderno de Estudos e Soluções SQL/Python

Este repositório é meu **Knowledge Base** e caderno de anotações focado em **Análise, Transformação (ELT)** e **Modelagem de Dados**. Contém *snippets* de código, exercícios práticos resolvidos e resumos de fórmulas para construção de pipelines analíticos robustos.

---

## 🛠️ Conteúdo Destaque

### 💾 SQL (Structured Query Language)

Foco em soluções de negócio usando SQL analítico e otimização de consultas em diferentes ambientes (SQLite, BigQuery).

#### ☁️ BigQuery (Google Cloud Platform)

Exemplos práticos de Engenharia de Dados e modelagem usando a sintaxe BigQuery SQL.

| Arquivo | Tópico Principal | Habilidades Demonstradas |
| :--- | :--- | :--- |
| **[00_Preparacao_Dados_Mobilidade.sql](./SQL/BigQuery/00_Preparacao_Dados_Mobilidade.sql)** | DDL/DML para **preparação de dados**. | `ALTER TABLE`, `UPDATE` e criação de colunas para análise. |
| **[01_DDL_e_DML_Exemplos.sql](./SQL/BigQuery/01_DDL_e_DML_Exemplos.sql")** | **Modelagem de Dados** e criação de estrutura para testes. | `CREATE TABLE`, `INSERT INTO` e construção de Schema Estrela básico (*mock data*). |
| **[02_Analise_Dias_Semana.sql](./SQL/BigQuery/02_Analise_Dias_Semana.sql)** | Ranqueamento de dias da semana por volume. | **Funções de Janela** (`ROW_NUMBER() OVER`) e agregação complexa. |
| **[03_Analise_Rotas_Simetricas.sql](./SQL/BigQuery/03_Analise_Rotas_Simetricas.sql)** | Análise de **simetria** em rotas de mobilidade. | Uso de **CTEs** e funções `LEAST/GREATEST` para modelagem de fluxo bidirecional. |


#### ⚙️ SQLite Analítico (Funções de Janela)

Estudos de *queries* aninhadas e Funções de Janela para ranqueamento e cálculo de métricas de **benchmark**.

| Arquivo | Pergunta de Negócio | Técnicas-Chave |
| :--- | :--- | :--- |
| **[01_Rank_Vendedor_Trimestral.sql](./SQL/SQLite/01_Rank_Vendedor_Trimestral.sql)** | Ranqueamento e performance de vendedores. | `DENSE_RANK() OVER()` e `AVG() OVER()` (Benchmark). |
| **[02_Musica_Mais_Lucrativa.sql](./SQL/SQLite/02_Musica_Mais_Lucrativa.sql)** | Identificação de itens mais lucrativos por categoria. | `ROW_NUMBER() OVER(PARTITION BY)` para ranqueamento particionado. |

---

### 🐍 Python para Dados

*Em breve: Estrutura para anotações de fundamentos, **Pandas** (DataFrames, ETL), **Numpy** e visualização.*

### 🛠️ Fórmulas M e DAX

| Arquivo | Tópico Principal (Aplicação de Negócio) | Técnicas-Chave |
| :--- | :--- | :--- |
|**[ZenithFlow: Módulo Financeiro](https://github.com/Nayarah/case-company_zenith-flow/tree/main/01_Financeiro_Inteligente)**|Pipeline de ETL Automatizado: Consolidação de Receitas e Despesas de Múltiplas Filiais.| **Linguagem M** (Ingestão, `Table.Combine`, Modelagem), **Automação VBA** (Distribuição de relatórios) |
|**[Power-Query_Linguegem-M_Folha-de-Dicas](./PowerQuery_Excel/power-query-m-language-cheatsheet.md)**|Referência Rápida: Performance e Funções M Avançadas (além da GUI).|`Table.Buffer` (Performance), `List.Accumulate` (Lógica), `Table.ExpandRecordColumn` (JSONs).|
|**[Linguagem-DAX-cheatsheet](./PowerBI-DAX/DAX-language-cheatsheet.md)**|Referência Rápida**DAX** para medidas e Time Intelligence no Power BI|Coluna calculada, Medida e Tabela calculada Funções de agregação `SUM()`; filtro e contexto`CALCULATE()`; Inteligencia de tempo `SAMEPERIODLASTYEAR()`; Lógica e condicionais `SWITCH()` e Contexto `RELATED()`
---

