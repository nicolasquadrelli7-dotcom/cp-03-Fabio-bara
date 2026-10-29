
-- ============================================
-- EXERCICIO 1.2 - CRUD SQL COMPLETO
-- SGBD: PostgreSQL
-- ============================================

-- Criar tabela de alertas, caso ainda nao exista
CREATE TABLE IF NOT EXISTS alertas (
    id_alerta BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    descricao TEXT NOT NULL,
    severidade VARCHAR(20) NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'aberto',
    data_criacao TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- (a) Inserir 3 alertas
INSERT INTO alertas (descricao, severidade, status)
VALUES
    ('Tentativas de login suspeitas', 'alta', 'aberto'),
    ('Porta desnecessaria exposta', 'media', 'aberto'),
    ('Software desatualizado', 'baixa', 'aberto');

-- (b) Listar apenas os alertas de severidade alta
SELECT *
FROM alertas
WHERE severidade = 'alta';

-- (c) Atualizar um alerta para resolvido
UPDATE alertas
SET status = 'resolvido'
WHERE id_alerta = 1;

-- (d) Contar alertas por severidade
SELECT severidade, COUNT(*) AS total_alertas
FROM alertas
GROUP BY severidade
ORDER BY severidade;

-- (e) Apagar alertas com mais de 90 dias
DELETE FROM alertas
WHERE data_criacao < CURRENT_TIMESTAMP - INTERVAL '90 days';

-- ============================================
-- FIM DO EXERCICIO 1.2
-- ============================================
