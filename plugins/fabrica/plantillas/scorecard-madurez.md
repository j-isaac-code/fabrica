# Scorecard de madurez (0–5 por eje)

Sirve para subir cada app al mismo estándar **cerrando brechas, sin reescribir**.

| Nota | Significado |
|---|---|
| 0 | No existe o se desconoce |
| 1 | Borrador o parcial, no usable |
| 2 | Existe pero frágil o incompleto |
| 3 | Usable en producción con brechas claras |
| 4 | Sólido; brechas menores documentadas |
| 5 | Referencia para las demás apps |

**Listo para plantilla:** todos los ejes en 4 o más, o un plan con fecha para los que falten.

| Eje | Qué mira | Nota | Evidencia | Brechas | Esfuerzo |
|---|---|---|---|---|---|
| QA | Tests, flujos críticos, regresiones | | | | |
| UI/UX | Consistencia, roles, estados vacíos y de error | | | | |
| Seguridad | Auth, permisos, secretos, validación, rate limit | | | | |
| Base de datos | Esquema, migraciones, respaldos, una sola capa de datos | | | | |
| Deuda técnica | Código muerto, dependencias, estructura | | | | |
| Docs | README, AGENTS.md, runbooks | | | | |
| Integraciones | Contratos, fallos y reintentos | | | | |
| Release / ops | CI, health con commit, logs, rollback, monitoreo | | | | |

**Orden de pasada (una app a la vez):** ficha → scorecard con evidencia real (45–90 min) → top 5 brechas por riesgo → un issue por brecha → re-score.

**Anti-patrones:** auditar todo a la vez con muchos agentes; reescribir la app; calificar por intuición.
