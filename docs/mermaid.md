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