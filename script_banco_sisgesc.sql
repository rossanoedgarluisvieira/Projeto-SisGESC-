CREATE DATABASE SisGESC;

USE SisGESC;



-- 1. Tabelas sem chaves estrangeiras

CREATE TABLE tb_alunos (

    pk_aluno INT PRIMARY KEY,

    nome_aluno VARCHAR(120) NOT NULL,

    cpf_aluno VARCHAR(11) NOT NULL UNIQUE,

    data_nascimento DATE NOT NULL,

    status_aluno VARCHAR(20) DEFAULT 'ativo',

    data_criacao DATE

);



CREATE TABLE tb_cursos (

    pk_curso INT PRIMARY KEY,

    nome_curso VARCHAR(100) NOT NULL UNIQUE,

    nivel VARCHAR(20),

    carga_horaria_total INT

);



CREATE TABLE tb_funcionarios (

    pk_funcionario INT PRIMARY KEY,

    cpf_funcionario CHAR(11) NOT NULL UNIQUE,

    nome_funcionario VARCHAR(120),

    cargo VARCHAR(50)

);



-- 2. Modulo Academico (Com FKs)

CREATE TABLE tb_disciplinas (

    pk_disciplina INT PRIMARY KEY,

    fk_curso INT NOT NULL,

    nome_disciplina VARCHAR(100) NOT NULL,

    FOREIGN KEY (fk_curso) REFERENCES tb_cursos(pk_curso)

);



CREATE TABLE tb_turmas (

    pk_turma INT PRIMARY KEY,

    fk_disciplina INT NOT NULL,

    nome_turma VARCHAR(50) NOT NULL,

    semestre VARCHAR(10) NOT NULL,

    FOREIGN KEY (fk_disciplina) REFERENCES tb_disciplinas(pk_disciplina)

);



CREATE TABLE tb_matriculas (

    pk_matricula INT PRIMARY KEY,

    fk_aluno INT NOT NULL,

    fk_turma INT NOT NULL,

    data_matricula DATE,

    situacao_disciplina VARCHAR(20),

    status_matricula VARCHAR(20),

    FOREIGN KEY (fk_aluno) REFERENCES tb_alunos(pk_aluno),

    FOREIGN KEY (fk_turma) REFERENCES tb_turmas(pk_turma)

);



CREATE TABLE tb_notas (

    pk_nota INT PRIMARY KEY,

    fk_matricula INT NOT NULL,

    nota DECIMAL(4,2) CHECK (nota BETWEEN 0 AND 10),

    FOREIGN KEY (fk_matricula) REFERENCES tb_matriculas(pk_matricula)

);



CREATE TABLE tb_faltas (

    pk_falta INT PRIMARY KEY,

    fk_matricula INT NOT NULL,

    quantidade_faltas INT,

    FOREIGN KEY (fk_matricula) REFERENCES tb_matriculas(pk_matricula)

);



-- 3. Modulo Financeiro

CREATE TABLE tb_contratos_educacionais (

    pk_contrato INT PRIMARY KEY,

    fk_aluno INT NOT NULL,

    semestre VARCHAR(10),

    data_assinatura DATE,

    valor_total_semestre DECIMAL(10,2),

    status_contrato VARCHAR(20),

    FOREIGN KEY (fk_aluno) REFERENCES tb_alunos(pk_aluno)

);



CREATE TABLE tb_mensalidades (

    pk_mensalidade INT PRIMARY KEY,

    fk_contrato INT NOT NULL,

    data_vencimento DATE NOT NULL,

    valor_parcela DECIMAL(10,2) NOT NULL,

    status_pagamento VARCHAR(20) DEFAULT 'pendente',

    FOREIGN KEY (fk_contrato) REFERENCES tb_contratos_educacionais(pk_contrato)

);



CREATE TABLE tb_pagamentos (

    pk_pagamento INT PRIMARY KEY,

    fk_mensalidade INT NOT NULL,

    data_pagamento DATE,

    valor_pago DECIMAL(10,2),

    FOREIGN KEY (fk_mensalidade) REFERENCES tb_mensalidades(pk_mensalidade)

);



CREATE TABLE tb_inadimplencia (

    pk_inadimplencia INT PRIMARY KEY,

    fk_mensalidade INT NOT NULL,

    dias_atraso INT,

    status_inadimplencia VARCHAR(20),

    FOREIGN KEY (fk_mensalidade) REFERENCES tb_mensalidades(pk_mensalidade)

);



-- 4. Modulo RH

CREATE TABLE tb_professores (

    pk_professor INT PRIMARY KEY,

    fk_funcionario INT NOT NULL UNIQUE,

    titulacao_maxima VARCHAR(50),

    FOREIGN KEY (fk_funcionario) REFERENCES tb_funcionarios(pk_funcionario)

);



CREATE TABLE tb_vinculo_docentes (

    pk_vinculo INT PRIMARY KEY,

    fk_professor INT NOT NULL,

    fk_disciplina INT NOT NULL,

    carga_horaria_atribuida INT,

    FOREIGN KEY (fk_professor) REFERENCES tb_professores(pk_professor),

    FOREIGN KEY (fk_disciplina) REFERENCES tb_disciplinas(pk_disciplina)

);