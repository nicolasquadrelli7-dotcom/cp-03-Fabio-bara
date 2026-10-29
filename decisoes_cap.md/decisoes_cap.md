

# Exercício 1.3 — Decisão de Arquitetura com CAP

| Cenário | CP/AP | Justificativa |
|---|---|---|
| 1. Saldo bancário de clientes | CP | A consistência é essencial para evitar saldos incorretos. É melhor bloquear temporariamente uma operação do que permitir divergências entre réplicas. |
| 2. Ingestão de 500 mil eventos de firewall por minuto num SOC | AP | A disponibilidade é importante para receber um grande volume de eventos continuamente. Pequenos atrasos na replicação podem ser aceitos para evitar a perda de telemetria. |
| 3. Cache de tokens de sessão de usuários logados | AP | A disponibilidade permite validar sessões mesmo com falhas temporárias de comunicação entre regiões. Uma pequena defasagem pode ser tolerada, dependendo do risco e das regras de segurança. |
| 4. Registro de quem autorizou cada transferência (auditoria) | CP | O registro precisa ser consistente e confiável para comprovar quem autorizou a transferência. É preferível recusar temporariamente uma gravação a manter registros divergentes. |
| 5. Feed de indicadores de ameaça (IOCs) replicado em 5 regiões | AP | É importante que os indicadores estejam disponíveis nas cinco regiões. Pequenos atrasos na atualização dos IOCs podem ser tolerados enquanto as réplicas são sincronizadas. |
