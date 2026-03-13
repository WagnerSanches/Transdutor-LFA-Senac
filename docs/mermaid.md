stateDiagram-v2
    direction TB

    %% --- CLASSE DE MILHARES ---
    state "Milhares" as M_Block {
        m0: q4_m
        mM: q4_M
        mMM: q4_MM
        mMMM: q4_MMM

        m0 --> mM: M / +1000
        mM --> mMM: M / +1000
        mMM --> mMMM: M / +1000
        
        %% Transições Épsilon para a próxima classe
        m0 --> c0: ε
        mM --> c0: ε
        mMM --> c0: ε
        mMMM --> c0: ε
    }

    %% --- CLASSE DE CENTENAS ---
    state "Centenas" as C_Block {
        c0: q3_c
        cC: q3_C
        cCC: q3_CC
        cCCC: q3_CCC
        cCD: q3_CD
        cCM: q3_CM
        cD: q3_D
        cDC: q3_DC
        cDCC: q3_DCC
        cDCCC: q3_DCCC

        c0 --> cC: C / +100
        cC --> cCC: C / +100
        cCC --> cCCC: C / +100
        cC --> cCD: D / +300
        cC --> cCM: M / +800
        c0 --> cD: D / +500
        cD --> cDC: C / +100
        cDC --> cDCC: C / +100
        cDCC --> cDCCC: C / +100

        %% Transições Épsilon para a próxima classe
        c0 --> d0: ε
        cC --> d0: ε
        cCC --> d0: ε
        cCCC --> d0: ε
        cCD --> d0: ε
        cCM --> d0: ε
        cD --> d0: ε
        cDC --> d0: ε
        cDCC --> d0: ε
        cDCCC --> d0: ε
    }

    %% --- CLASSE DE DEZENAS ---
    state "Dezenas" as D_Block {
        d0: q2_d
        dX: q2_X
        dXX: q2_XX
        dXXX: q2_XXX
        dXL: q2_XL
        dXC: q2_XC
        dL: q2_L
        dLX: q2_LX
        dLXX: q2_LXX
        dLXXX: q2_LXXX

        d0 --> dX: X / +10
        dX --> dXX: X / +10
        dXX --> dXXX: X / +10
        dX --> dXL: L / +30
        dX --> dXC: C / +80
        d0 --> dL: L / +50
        dL --> dLX: X / +10
        dLX --> dLXX: X / +10
        dLXX --> dLXXX: X / +10

        %% Transições Épsilon para a próxima classe
        d0 --> u0: ε
        dX --> u0: ε
        dXX --> u0: ε
        dXXX --> u0: ε
        dXL --> u0: ε
        dXC --> u0: ε
        dL --> u0: ε
        dLX --> u0: ε
        dLXX --> u0: ε
        dLXXX --> u0: ε
    }

    %% --- CLASSE DE UNIDADES ---
    state "Unidades" as U_Block {
        u0: q1_u
        uI: q1_I
        uII: q1_II
        uIII: q1_III
        uIV: q1_IV
        uIX: q1_IX
        uV: q1_V
        uVI: q1_VI
        uVII: q1_VII
        uVIII: q1_VIII

        u0 --> uI: I / +1
        uI --> uII: I / +1
        uII --> uIII: I / +1
        uI --> uIV: V / +3
        uI --> uIX: X / +8
        u0 --> uV: V / +5
        uV --> uVI: I / +1
        uVI --> uVII: I / +1
        uVII --> uVIII: I / +1

        %% Estados de Aceitação (Finais)
        u0 --> [*]
        uI --> [*]
        uII --> [*]
        uIII --> [*]
        uIV --> [*]
        uIX --> [*]
        uV --> [*]
        uVI --> [*]
        uVII --> [*]
        uVIII --> [*]
    }

    %% Início de tudo
    [*] --> m0