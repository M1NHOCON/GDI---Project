# 🏨 Sistema de Gerenciamento Hoteleiro – Banco de Dados

Este projeto consiste na modelagem e implementação de um banco de dados relacional para um sistema de gerenciamento de hotel, desenvolvido e testado na plataforma **Oracle Live SQL**.

## 📌 Objetivo

Gerenciar operações de um hotel, incluindo cadastro e relacionamento entre clientes, funcionários, reservas, setores, quartos, pagamentos e comodidades, garantindo integridade e organização dos dados.

---

## 🧱 Tecnologias Utilizadas

- **SGBD:** Oracle Database
- **Plataforma:** Oracle Live SQL (https://livesql.oracle.com)
- **Linguagem:** Oracle SQL (`VARCHAR2`, `NUMBER`, constraints explícitas)

---

## 🧩 Modelagem do Banco

### Modelo Conceitual

O projeto foi modelado com base no diagrama Entidade-Relacionamento (MER), contendo entidades como `Hotel`, `Funcionario`, `Cliente`, `Quarto`, `Reserva`, `Pagamento`, entre outras, com relacionamentos como:

- `Faz_Reserva`
- `Efetua`
- `Trabalha`
- `Pertence`
- `Chefia`
- `Tem` (Hotel/Comodidade e Quarto/Comodidade)

### Modelo Lógico

A versão relacional das entidades inclui o uso de chaves primárias, estrangeiras (inclusive compostas), e normalização até a 3ª forma normal.

---

## 📄 Estrutura das Tabelas (exemplos)

### 🔹 Reserva

| Campo        | Tipo          | Descrição                        |
|--------------|---------------|----------------------------------|
| ID_Res       | NUMBER (PK)   | Identificador da reserva         |
| Num_Hospedes | NUMBER        | Número de hóspedes               |
| Status       | VARCHAR2(20)  | Situação da reserva              |
| Valor_Total  | NUMBER(10,2)  | Valor total da reserva           |

### 🔹 Funcionario

| Campo       | Tipo              | Descrição                           |
|-------------|-------------------|--------------------------------------|
| CPF         | VARCHAR2(11) (PK) | Identificador do funcionário         |
| Nome        | VARCHAR2(100)     | Nome completo                        |
| Telefone    | VARCHAR2(20)      | Contato                             |
| Salário     | NUMBER(10,2)      | Salário                             |
| Cargo       | VARCHAR2(50)      | Cargo ocupado                        |
| CPF_Chefe   | VARCHAR2(11) (FK) | Supervisor imediato (auto-relacion.) |

---

## 🔗 Relacionamentos Importantes

- Cada **cliente** pode realizar **várias reservas**, que podem envolver **vários quartos**.
- Cada **reserva** pode ter **um ou mais pagamentos**.
- Cada **hotel** possui **setores**, e cada setor conta com **funcionários**.
- Cada **hotel** e **quarto** pode ter várias **comodidades**.
- **Funcionários** podem gerenciar hotéis ou supervisionar outros funcionários.

---

## 📂 Scripts SQL

Todos os scripts de criação das tabelas, constraints e relacionamentos estão disponíveis no arquivo `script.sql`.

---

## 📌 Observações Finais

- Projeto acadêmico executado com sucesso no Oracle Live SQL.
- Todas as tabelas possuem suas constraints de integridade referencial devidamente implementadas.
- O modelo segue as boas práticas de modelagem de dados, com chaves compostas, normalização e documentação clara.

---
