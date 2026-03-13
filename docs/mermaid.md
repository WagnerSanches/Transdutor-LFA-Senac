# Transdutor de Mealy para Algarismos Romanos

## 1. Definição Formal
A máquina desenvolvida é um **Transdutor de Mealy**, formalizado pela sêxtupla:
$M = (Q, \Sigma, \Gamma, \delta, \omega, q_0)$

- **Q**: Conjunto de estados $\{q_0, q_{1\_u}, q_{1\_I}, q_{2\_X}, \dots\}$
- **Σ (Entrada)**: $\{I, V, X, L, C, D, M\}$
- **Γ (Saída)**: Valores inteiros acumulados $\{1, 3, 5, 8, 10, 30, \dots\}$
- **δ**: Função de transição de estados.
- **ω**: Função de saída (emite o valor durante a transição).
- **q0**: Estado inicial.

## 2. Tipo de Transdutor
O modelo é **Mealy** porque a saída (incremento do valor decimal) é determinada pelo **par (estado atual, símbolo de entrada)**. 

**Exemplo de lógica Mealy no código:**
- Ao ler `I` em $q_0$, a saída é `+1`.
- Se o próximo símbolo for `V`, a saída da transição é `+3` (correção para totalizar 4). 
Em uma máquina de Moore, o valor estaria fixo no estado, o que dificultaria essa compensação imediata de símbolos subtrativos.

## 3. Alfabetos e Transições
- **Entrada**: Caracteres da cadeia romana.
- **Saída**: Valores somados à variável `@value`.

**Transições:**
1. **Sem saída (Controle):** Transições de $q_0$ para as funções de classe (ex: `unidade_milhar`) apenas direcionam o fluxo.
2. **Com saída (Emissão):** Transições dentro dos loops (ex: `in ["X", "q2_d"]` emitindo `@value += 10`).

## 4. Diagrama Mermaid
O código abaixo deve ser armazenado em `/docs/diagrama.md`.

```mermaid
stateDiagram-v2
    direction LR

    [*] --> q0

    state "Milhar" as M_Block {
        q4_m --> q4_M: M / +1000
        q4_M --> q4_MM: M / +1000
    }

    state "Centena" as C_Block {
        q3_c --> q3_C: C / +100
        q3_C --> q3_D: D / +300 (CD)
        q3_c --> q3_D_full: D / +500
    }

    state "Dezena" as D_Block {
        q2_d --> q2_X: X / +10
        q2_X --> q2_L: L / +30 (XL)
        q2_d --> q2_L_full: L / +50
    }

    state "Unidade" as U_Block {
        q1_u --> q1_I: I / +1
        q1_I --> q1_V: V / +3 (IV)
        q1_u --> q1_V_full: V / +5
        q1_I --> q1_X: X / +8 (IX)
    }

    q0 --> M_Block: M
    q0 --> C_Block: C, D
    q0 --> D_Block: X, L
    q0 --> U_Block: I, V

    M_Block --> C_Block
    C_Block --> D_Block
    D_Block --> U_Block

    U_Block --> [*]