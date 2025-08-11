
# 🏥 Banco de Dados - Prontuário Eletrônico

Este documento descreve a estrutura de tabelas e campos de um banco de dados MySQL para um sistema de Prontuário Eletrônico.

---

## 1. pacientes

**Descrição**: Armazena dados básicos dos pacientes.

| Campo            | Tipo             | Descrição                        |
|------------------|------------------|----------------------------------|
| id               | INT (PK, AI)     | Identificador do paciente        |
| nome             | VARCHAR(100)     | Nome completo                    |
| cpf              | VARCHAR(14)      | CPF do paciente                  |
| data_nascimento  | DATE             | Data de nascimento               |
| sexo             | ENUM('M','F','O')| Gênero biológico                 |
| telefone         | VARCHAR(20)      | Contato telefônico               |
| email            | VARCHAR(100)     | E-mail                           |
| endereco         | VARCHAR(255)     | Endereço completo                |
| criado_em        | DATETIME         | Data de cadastro                 |

---

## 2. profissionais

**Descrição**: Profissionais da saúde que atendem os pacientes.

| Campo           | Tipo             | Descrição                        |
|----------------|------------------|----------------------------------|
| id             | INT (PK, AI)     | Identificador do profissional    |
| nome           | VARCHAR(100)     | Nome completo                    |
| cpf            | VARCHAR(14)      | CPF                              |
| registro       | VARCHAR(20)      | CRM/COREN/CRP, etc.              |
| especialidade  | VARCHAR(100)     | Área de atuação                  |
| email          | VARCHAR(100)     | E-mail                           |
| telefone       | VARCHAR(20)      | Telefone                         |

---

## 3. atendimentos

**Descrição**: Representa uma consulta ou sessão individual.

| Campo            | Tipo           | Descrição                          |
|------------------|----------------|------------------------------------|
| id               | INT (PK, AI)   | ID do atendimento                  |
| paciente_id      | INT (FK)       | ID do paciente                     |
| profissional_id  | INT (FK)       | ID do profissional                 |
| data_hora        | DATETIME       | Data e hora do atendimento         |
| tipo             | VARCHAR(50)    | Consulta, retorno, emergência etc. |
| motivo           | TEXT           | Queixa principal                   |
| observacoes      | TEXT           | Anotações gerais                   |

---

## 4. anamnese

**Descrição**: Questionário inicial do paciente.

| Campo              | Tipo          | Descrição                        |
|--------------------|---------------|----------------------------------|
| id                 | INT (PK, AI)  | ID da anamnese                   |
| paciente_id        | INT (FK)      | Relacionado ao paciente          |
| atendimento_id     | INT (FK)      | (Opcional) atendimento relacionado |
| historico_familiar | TEXT          | Doenças na família               |
| historico_pessoal  | TEXT          | Doenças preexistentes            |
| uso_medicamentos   | TEXT          | Remédios de uso contínuo         |
| alergias           | TEXT          | Possíveis alergias               |
| criado_em          | DATETIME      | Data de preenchimento            |

---

## 5. prontuario

**Descrição**: Detalhes clínicos do atendimento.

| Campo           | Tipo          | Descrição                          |
|-----------------|---------------|------------------------------------|
| id              | INT (PK, AI)  | ID do registro do prontuário       |
| atendimento_id  | INT (FK)      | Atendimento relacionado            |
| sinais_vitais   | TEXT          | Pressão, temperatura, etc.         |
| diagnostico     | TEXT          | Diagnóstico clínico                |
| conduta         | TEXT          | Condutas tomadas                   |
| exames_pedidos  | TEXT          | Lista de exames solicitados        |
| retorno_em      | DATE          | Data sugerida para retorno         |

---

## 6. receitas

**Descrição**: Prescrições médicas feitas durante o atendimento.

| Campo          | Tipo          | Descrição                        |
|----------------|---------------|----------------------------------|
| id             | INT (PK, AI)  | ID da receita                    |
| atendimento_id | INT (FK)      | Atendimento relacionado          |
| medicamentos   | TEXT          | Lista com posologia              |
| orientacoes    | TEXT          | Instruções adicionais            |
| data_emissao   | DATE          | Data da receita                  |

---

## 7. exames

**Descrição**: Resultados de exames realizados ou solicitados.

| Campo           | Tipo           | Descrição                        |
|-----------------|----------------|----------------------------------|
| id              | INT (PK, AI)   | ID do exame                      |
| atendimento_id  | INT (FK)       | Atendimento relacionado          |
| tipo_exame      | VARCHAR(100)   | Tipo do exame (ex: hemograma)    |
| resultado       | TEXT           | Resultado do exame               |
| data_resultado  | DATE           | Data do exame                    |
| arquivo_url     | VARCHAR(255)   | Link para PDF ou imagem (opcional) |

---

## 8. agendamentos

**Descrição**: Controle de agendamentos futuros.

| Campo            | Tipo           | Descrição                          |
|------------------|----------------|------------------------------------|
| id               | INT (PK, AI)   | ID do agendamento                  |
| paciente_id      | INT (FK)       | Paciente                           |
| profissional_id  | INT (FK)       | Profissional                       |
| data_hora        | DATETIME       | Data e hora                        |
| status           | ENUM(...)      | 'marcado', 'realizado', 'cancelado' |

---

## 🔗 Relacionamentos entre tabelas

- `pacientes` → 1:N → `atendimentos`
- `profissionais` → 1:N → `atendimentos`
- `atendimentos` → 1:1 ou 1:N → `prontuario`, `receitas`, `exames`
- `pacientes` → 1:N → `anamnese`, `agendamentos`

---
