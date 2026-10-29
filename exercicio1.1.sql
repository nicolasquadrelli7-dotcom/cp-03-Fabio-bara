

-- ============================================
-- BANCO DE DADOS: GERENCIAMENTO DE VULNERABILIDADES
-- SGBD: PostgreSQL
-- ============================================

-- 1. TABELA DE ATIVOS
CREATE TABLE ativos (
    id_ativo BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    endereco_ip VARCHAR(45),
    sistema_operacional VARCHAR(100),
    ambiente VARCHAR(30),
    data_cadastro TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- 2. TABELA DE VULNERABILIDADES
CREATE TABLE vulnerabilidades (
    id_vulnerabilidade BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    cve VARCHAR(20) UNIQUE,
    titulo VARCHAR(200) NOT NULL,
    descricao TEXT,
    cvss DECIMAL(3,1),
    data_publicacao DATE,

    CONSTRAINT chk_cvss
        CHECK (cvss IS NULL OR (cvss >= 0 AND cvss <= 10))
);

-- 3. TABELA DE RELACIONAMENTO
CREATE TABLE ativo_vulnerabilidade (
    id_ativo_vulnerabilidade BIGINT
        GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    id_ativo BIGINT NOT NULL,
    id_vulnerabilidade BIGINT NOT NULL,
    data_deteccao TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) NOT NULL DEFAULT 'Aberta',
    severidade VARCHAR(20),
    data_correcao TIMESTAMP,

    -- Chave estrangeira para ativos
    CONSTRAINT fk_av_ativo
        FOREIGN KEY (id_ativo)
        REFERENCES ativos(id_ativo)
        ON DELETE CASCADE,

    -- Chave estrangeira para vulnerabilidades
    CONSTRAINT fk_av_vulnerabilidade
        FOREIGN KEY (id_vulnerabilidade)
        REFERENCES vulnerabilidades(id_vulnerabilidade)
        ON DELETE CASCADE,

    -- Impede associações duplicadas
    CONSTRAINT uq_ativo_vulnerabilidade
        UNIQUE (id_ativo, id_vulnerabilidade),

    -- Validação do status
    CONSTRAINT chk_status
        CHECK (status IN (
            'Aberta',
            'Em andamento',
            'Corrigida',
            'Aceita'
        )),

    -- Validação da severidade
    CONSTRAINT chk_severidade
        CHECK (
            severidade IS NULL OR severidade IN (
                'Baixa',
                'Media',
                'Alta',
                'Critica'
            )
        ),

    -- Validação da data de correção
    CONSTRAINT chk_data_correcao
        CHECK (
            data_correcao IS NULL
            OR data_correcao >= data_deteccao
        )
);

-- 4. ÍNDICES PARA MELHORAR AS CONSULTAS
CREATE INDEX idx_av_id_ativo
    ON ativo_vulnerabilidade(id_ativo);

CREATE INDEX idx_av_id_vulnerabilidade
    ON ativo_vulnerabilidade(id_vulnerabilidade);

CREATE INDEX idx_av_status
    ON ativo_vulnerabilidade(status);

-- ============================================
-- FIM DO SCRIPT
-- ============================================

